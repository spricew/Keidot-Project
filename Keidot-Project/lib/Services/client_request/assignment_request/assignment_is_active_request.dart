import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/presentation/screens/requests_screen.dart';

class UpdateIsActiveService {
  final String baseUrl =
      "https://keidot.azurewebsites.net/api/ServiceAssigment";
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger();

  Future<bool> updateIsActive(BuildContext context, bool isActive) async {
    try {
      print('Valor de is_active $isActive');
      final AssignmentIdController assignmentController =
          Get.find<AssignmentIdController>(); // Obtener el controlador

      String? assignmentId = assignmentController
          .selectedAssignmentId; // Obtener el ID del controlador
      String? token = await storage.read(key: 'token');

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
        body: jsonEncode(isActive),
      );

      if (response.statusCode == 200) {
        logger.i(
            "Estado 'is_active' actualizado correctamente para la asignación $assignmentId");

        // Reemplaza la pantalla actual con la Homepage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RequestsScreen()),
        );

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
