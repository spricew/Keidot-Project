import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_app/Services/assignment_request/assignment_controller.dart';

class UpdateIsActiveService {
  final String baseUrl =
      "https://keidot.azurewebsites.net/api/ServiceAssigment";
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger();

  Future<bool> updateIsActive(bool isActive) async {
    try {
      final AssignmentIdController assignmentController =
          Get.find<AssignmentIdController>(); // Obtener el controlador
      String? token = await storage.read(key: 'token');
      String? assignmentId = assignmentController.selectedAssignmentId; // Obtener el ID del controlador

      if (token == null || assignmentId == null) {
        logger.e("Falta el token o el assignmentId en el controlador");
        return false;
      }

      final url = Uri.parse("$baseUrl/update-is-active/$assignmentId");
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"is_active": isActive}),
      );

      if (response.statusCode == 200) {
        logger.i(
            "Estado 'is_active' actualizado correctamente para la asignación $assignmentId");
        return true;
      } else {
        logger
            .w("Error al actualizar 'is_active'. Respuesta: ${response.body}");
        return false;
      }
    } catch (e) {
      logger.e("Excepción al actualizar 'is_active': $e");
      return false;
    }
  }
}
