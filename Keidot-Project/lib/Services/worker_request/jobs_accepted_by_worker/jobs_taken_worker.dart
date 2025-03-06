import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class AcceptedJobsService {
  String baseUrl = 'https://keidot.azurewebsites.net';
  final FlutterSecureStorage storage;
  final Logger logger = Logger();

  AcceptedJobsService({required this.storage});
  Future<List<dynamic>> fetchAcceptedJobs(String workerId) async {
    try {
      String? token = await storage.read(key: "token");
      if (token == null) {
        logger.e("Token no encontrado en el almacenamiento seguro.");
        throw Exception("Token no encontrado.");
      }

      final Uri url = Uri.parse('$baseUrl/api/AssignmentByUser/JobsAccepted/$workerId');
      logger.i("Enviando solicitud GET a: $url");

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      logger.i("Código de respuesta: ${response.statusCode}");
      logger.d("Respuesta del servidor: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> jobs = jsonDecode(response.body);
        logger.i("Trabajos aceptados recuperados exitosamente.");
        return jobs;
      } else {
        logger.e("Error al obtener los trabajos aceptados: ${response.body}");
        throw Exception("Error en la solicitud: ${response.body}");
      }
    } catch (e) {
      logger.e("Excepción al obtener los trabajos aceptados: $e");
      throw Exception("Error inesperado: $e");
    }
  }
}
