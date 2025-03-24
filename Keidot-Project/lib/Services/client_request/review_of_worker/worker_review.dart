import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';

class WorkerReviewForClient {
  final String baseUrl = 'https://keidotapi.azurewebsites.net/api/Reviews/worker';
  final Logger logger = Logger();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  
 Future<List<Map<String, dynamic>>?> fetchReview() async {
  try {
   final workerId = Get.find<AssignmentIdController>().selectedWorkerId;

    
    if (workerId == null) {
      logger.e("Error: No se encontró el ID del trabajador en el almacenamiento");
      return null;
    }

    String? token = await storage.read(key: "token");
    final response = await http.get(
      Uri.parse('$baseUrl/$workerId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      logger.i("Reseñas obtenidas correctamente: $data");

      return data.cast<Map<String, dynamic>>(); // Convertir List<dynamic> a List<Map<String, dynamic>>
    } else {
      logger.e("Error al obtener reseñas: ${response.body}");
      return null;
    }
  } catch (e) {
    logger.e("Error en la solicitud: $e");
    return null;
  }
}
}
