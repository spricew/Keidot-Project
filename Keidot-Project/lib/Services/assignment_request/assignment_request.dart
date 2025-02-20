import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:test_app/Services/models/assignment_model.dart';

class AssignmentController {
  final String baseUrl = "https://keidot.azurewebsites.net/api/AssignmentByUser/user";
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger(); // Instancia de Logger

  /// Obtiene el ID del usuario autenticado desde el almacenamiento seguro
  Future<String?> getUserId() async {
    String? userId = await storage.read(key: 'userId');
    logger.i("🔍 ID recuperado del almacenamiento seguro: $userId");
    return userId;
  }

  /// Obtiene el token de autenticación desde el almacenamiento seguro
  Future<String?> getToken() async {
    String? token = await storage.read(key: 'token');
    logger.i("Token recuperado: $token");
    return token;
  }

  /// Obtiene las solicitudes del usuario autenticado
  Future<List<AssignmentDTO>> getAssignments() async {
    try {
      String? userId = await getUserId();
      String? token = await getToken();

      if (userId == null) {
        throw Exception("No se encontró el ID del usuario en el almacenamiento.");
      }
      if (token == null) {
        throw Exception("No se encontró el token en el almacenamiento.");
      }

      final url = '$baseUrl/$userId';
      logger.i("URL de la solicitud: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      logger.i("Enviando solicitud GET a: $url");
      logger.i("Headers: ${response.request?.headers}");

      if (response.statusCode == 200) {
        logger.i("Respuesta recibida correctamente.");
        logger.i("Cuerpo de la respuesta: ${response.body}");

        List<dynamic> data = jsonDecode(response.body);

        if (data.isEmpty) {
          logger.w("La respuesta no contiene asignaciones.");
          return [];
        }

        return data.map((json) {
          var tiempoEstimadoRaw = json["tiempo_estimado"];
          int tiempoEnMinutos;

          if (tiempoEstimadoRaw is String) {
            try {
              List<String> partes = tiempoEstimadoRaw.split(':');
              if (partes.length >= 2) {
                int horas = int.parse(partes[0]);
                int minutos = int.parse(partes[1]);
                tiempoEnMinutos = (horas * 60) + minutos;
              } else {
                throw const FormatException("Formato incorrecto en tiempo_estimado");
              }
            } catch (e) {
              logger.w("Error al parsear tiempo_estimado: $tiempoEstimadoRaw - $e");
              tiempoEnMinutos = 0;
            }
          } else if (tiempoEstimadoRaw is int) {
            tiempoEnMinutos = tiempoEstimadoRaw;
          } else {
            logger.w("tiempo_estimado tiene un formato desconocido: $tiempoEstimadoRaw");
            tiempoEnMinutos = 0;
          }

          return AssignmentDTO.fromJson({
            ...json,
            "tiempo_estimado": tiempoEnMinutos,
          });
        }).toList();
      } else {
        logger.e("Error ${response.statusCode}: ${response.body}");
        throw Exception("Error al obtener las solicitudes: ${response.body}");
      }
    } catch (e) {
      logger.e("Excepción en la solicitud: $e");
      throw Exception("Error en la solicitud: $e");
    }
  }
}
