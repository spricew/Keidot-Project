import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/presentation/screens/home_page.dart';

//Para marcar como "En progreso" ya que el trabajador ha aceptado la solicitud
class AssignmentSuccess {
  final String baseUrl =
      "https://keidotapi.azurewebsites.net/api/ServiceAssigment";
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger();

  Future<bool> updateIsActive(
    BuildContext context,
  ) async {
    String accept = "En progreso";
    try {
      final AssignmentIdController assignmentController =
          Get.find<AssignmentIdController>(); // Obtener el controlador

      String? assignmentId = assignmentController
          .selectedAssignmentId; // Obtener el ID del controlador
      String? token = await storage.read(key: 'token');

      if (token == null || assignmentId == null) {
        logger.e("Falta el token o el assignmentId en el controlador");
        return false;
      }

      final url = Uri.parse("$baseUrl/update-requests/$assignmentId");
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(accept),
      );

      if (response.statusCode == 200) {
        logger.i(
            "Estado 'Aceptado' correctamente para la asignación $assignmentId");

        // Reemplaza la pantalla actual con la Homepage
        Get.snackbar("Éxito", "Haz aceptado la solicitud");
        Get.off(() => const Homepage());

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
