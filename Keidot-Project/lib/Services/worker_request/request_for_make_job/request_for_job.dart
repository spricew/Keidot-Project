import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';

class AssignmentAcceptedByWorker {
  String baseUrl;
  final FlutterSecureStorage storage;
  final Logger logger = Logger(); // Logger para depuración

  AssignmentAcceptedByWorker({required this.baseUrl, required this.storage});

  Future<bool> updateAssignmentStatus() async {
    try {
      // Leer workerId y token desde el storage
      final AssignmentIdController assignmentController =
          Get.find<AssignmentIdController>();
      String? workerId = await storage.read(key: "userId");
      String? token = await storage.read(key: "token");
      String? assignmentId = assignmentController.selectedAssignmentId;

      if (workerId == null || token == null || assignmentId == null) {
        logger.e("Error: workerId, token o assignmentId son nulos.");
        throw Exception("workerId, token o assignmentId son nulos.");
      }

      final Uri url = Uri.parse(
          '$baseUrl/api/AssignmentByUser/ApplyingForAJob?assignmentId=$assignmentId&workerId=$workerId');

      /*String? userId = await storage.read(key: "userId"); // Id del usuario actual

      if (workerId == userId) {
      logger.e("No puedes tomar tus probios trabajos.");
      throw Exception("No puedes tomar tus probios trabajos.");
      }*/

      logger.i("Enviando solicitud a: $url");

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      logger.i("Código de respuesta: ${response.statusCode}");
      logger.i("Respuesta del servidor: ${response.body}");

      if (response.statusCode == 200) {
        logger.i("Estado actualizado correctamente.");
        return true;
      } else {
        logger.e("Error en la respuesta del servidor: ${response.body}");
        return false;
      }
    } catch (e) {
      logger.e("Excepción atrapada: $e");
      return false;
    }
  }
}
