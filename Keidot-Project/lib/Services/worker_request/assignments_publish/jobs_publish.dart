import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:test_app/Services/models/assignment_model.dart';

class JobsPublishService {
  final Logger _logger = Logger();
  final String baseUrl = "https://keidot.azurewebsites.net/api/AssignmentByUser"; // Reemplaza con la URL real

  Future<List<AssignmentDTO>> fetchAllJobs() async {
    final url = Uri.parse("$baseUrl/WorkerServices");

    try {
      _logger.i("Obteniendo trabajos publicados desde: $url");

      final response = await http.get(url);

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
