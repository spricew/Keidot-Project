import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/Services/models/assignment_model.dart';

class AssignmentController {
  final String baseUrl = "https://keidot.azurewebsites.net/api/AssignmentByUser/user";
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Obtiene el ID del usuario autenticado desde el almacenamiento seguro
  Future<String?> getUserId() async {
    return await storage.read(key: 'userId');
  }

  /// Obtiene el token de autenticación desde el almacenamiento seguro
  Future<String?> getToken() async {
    return await storage.read(key: 'token');
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

      final response = await http.get(
        Uri.parse('$baseUrl/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => AssignmentDTO.fromJson(json)).toList();
      } else {
        throw Exception("Error al obtener las solicitudes: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error en la solicitud: $e");
    }
  }
}
