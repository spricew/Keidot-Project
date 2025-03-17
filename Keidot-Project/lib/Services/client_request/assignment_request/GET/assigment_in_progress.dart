import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:test_app/Services/models/assignment_model.dart';

class AssignmentInProgress {
  final String baseUrl = "https://keidot.azurewebsites.net/api/AssignmentByUser/Client/JobsInProgress";
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger(); // Instancia de Logger

  /// Obtiene el ID del usuario autenticado desde el almacenamiento seguro
  Future<String?> getUserId() async {
    String? userId = await storage.read(key: 'userId');
    logger.i("ID recuperado del almacenamiento seguro: $userId");
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

    if (response.statusCode == 200) {
      logger.i("Respuesta recibida correctamente.");
      List<dynamic> data = jsonDecode(response.body);
      logger.i(response.body);
      if (data.isEmpty) {
        logger.w("La respuesta no contiene asignaciones.");
        return [];
      }

      return data.map((json) {
        var estimatedSizeRaw = json["estimated_size"];
        String estimatedSize;

        if (estimatedSizeRaw is String) {
          estimatedSize = estimatedSizeRaw;
        } else if (estimatedSizeRaw != null) {
          estimatedSize = estimatedSizeRaw.toString();
        } else {
          logger.w("estimated_size es nulo o tiene un formato desconocido.");
          estimatedSize = "Desconocido";
        }

        return AssignmentDTO.fromJson({
          ...json,
          "estimated_size": estimatedSize, // Reemplazando tiempoEstimado
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
