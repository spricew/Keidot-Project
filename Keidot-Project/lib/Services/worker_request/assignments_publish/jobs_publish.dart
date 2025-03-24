import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_app/Services/models/assignment_model.dart';

class JobsPublishService {
  final Logger _logger = Logger();
  final String baseUrl = "https://keidotapi.azurewebsites.net/api/AssignmentByUser/Worker";
  FlutterSecureStorage storage = const FlutterSecureStorage(); // Almacenamiento seguro

  Future<List<AssignmentDTO>> fetchAllJobs() async {
    String? UserId = await storage.read(key: "userId");
    final url = Uri.parse("$baseUrl/WorkerServices/$UserId");

    try {
      _logger.i("Obteniendo trabajos publicados desde: $url");

      // Recuperar el token del almacenamiento seguro
      final token = await storage.read(key: 'token');

      if (token == null) {
        _logger.e("Error: No se encontró el token.");
        return [];
      }

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<AssignmentDTO> assignments =
            data.map((json) => AssignmentDTO.fromJson(json)).toList();

        _logger.i("Se obtuvieron ${assignments.length} trabajos.");
        return assignments;
      } else {
        _logger.e("Error ${response.statusCode}: ${response.body}");
        return [];
      }
    } catch (e) {
      _logger.e("Excepción al obtener trabajos: $e");
      return [];
    }
  }
}
