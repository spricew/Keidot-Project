import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/Services/models/assignment_model.dart';

class AssignmentInactiveController {
  final String baseUrl =
      "https://keidot.azurewebsites.net/api/AssignmentByUser/serviceInactive";
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Obtiene el ID del usuario autenticado desde el almacenamiento seguro
  Future<String?> getUserId() async {
    String? userId = await storage.read(key: 'userId');
    return userId;
  }

  /// Obtiene el token de autenticación desde el almacenamiento seguro
  Future<String?> getToken() async {
    String? token = await storage.read(key: 'token');
    return token;
  }

  /// Obtiene las solicitudes del usuario autenticado
  Future<List<AssignmentDTO>> getAssignments() async {
    try {
      String? userId = await getUserId();
      String? token = await getToken();

      if (userId == null) {
        throw Exception(
            "No se encontró el ID del usuario en el almacenamiento.");
      }
      if (token == null) {
        throw Exception("No se encontró el token en el almacenamiento.");
      }

      final url = '$baseUrl/$userId';
      print("URL de la solicitud: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("Enviando solicitud GET a: $url");
      print("Headers: ${response.request?.headers}");

      if (response.statusCode == 200) {
        print("Respuesta recibida correctamente.");
        print("Cuerpo de la respuesta: ${response.body}");

        List<dynamic> data = jsonDecode(response.body);

        // Si la lista está vacía
        if (data.isEmpty) {
          print("La respuesta no contiene asignaciones.");
          return [];
        }

        return data.map((json) {
          var tiempoEstimadoRaw = json["tiempo_estimado"];
          int tiempoEnMinutos;

          if (tiempoEstimadoRaw is String) {
            try {
              // Verificar que tiene el formato correcto
              List<String> partes = tiempoEstimadoRaw.split(':');
              if (partes.length >= 2) {
                int horas = int.parse(partes[0]);
                int minutos = int.parse(partes[1]);
                tiempoEnMinutos = (horas * 60) + minutos;
              } else {
                throw const FormatException("Formato incorrecto en tiempo_estimado");
              }
            } catch (e) {
              print("Error al parsear tiempo_estimado: $tiempoEstimadoRaw - $e");
              tiempoEnMinutos = 0; // Valor por defecto en caso de error
            }
          } else if (tiempoEstimadoRaw is int) {
            // Si ya viene como número, lo tomamos directamente
            tiempoEnMinutos = tiempoEstimadoRaw;
          } else {
            // Si no es ni String ni int, asumimos 0 minutos
            print("tiempo_estimado tiene un formato desconocido: $tiempoEstimadoRaw");
            tiempoEnMinutos = 0;
          }

          return AssignmentDTO.fromJson({
            ...json,
            "tiempo_estimado": tiempoEnMinutos, // Se guarda en minutos
          });
        }).toList();
      } else {
        print("Error al obtener las solicitudes: ${response.statusCode}");
        print("Cuerpo del error: ${response.body}");
        throw Exception("Error al obtener las solicitudes: ${response.body}");
      }
    } catch (e) {
      print("Excepción en la solicitud: $e");
      throw Exception("Error en la solicitud: $e");
    }
  }
}
