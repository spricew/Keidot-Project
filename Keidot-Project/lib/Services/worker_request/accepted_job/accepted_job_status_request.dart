import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';

class AssignmentAcceptedByWorker {
  final String baseUrl;
  final FlutterSecureStorage storage;
  final Logger logger = Logger(); // Logger para depuración

  AssignmentAcceptedByWorker({required this.baseUrl, required this.storage});

  Future<bool> updateAssignmentStatus({
    required String newStatus,
  }) async {
    try {
      // Leer workerId y token desde el storage
      final AssignmentIdController assignmentController =
          Get.find<AssignmentIdController>(); 
      String? workerId = await storage.read(key: "userId");
      String? token = await storage.read(key: "token");
      String? assignmentId = assignmentController
          .selectedAssignmentId; // Obtener el ID del controlador

      if (workerId == null || token == null) {
        logger.e("No se encontró el ID de usuario o el token.");
        throw Exception("No se encontró el ID de usuario o el token.");
      }

      final Uri url = Uri.parse(
          '$baseUrl/api/assignments/update-status?assignmentId=$assignmentId&workerId=$workerId');

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token de autenticación
        },
        body: jsonEncode({'status': newStatus}), // Cuerpo de la solicitud
      );

      if (response.statusCode == 200) {
        logger.i("Estado actualizado correctamente.");
        return true;
      } else {
        logger.e("Error al actualizar el estado: ${response.body}");
        return false;
      }
    } catch (e) {
      logger.e("Error en la solicitud: $e");
      return false;
    }
  }
}
