import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/Services/models/location_model.dart';

class LocationService {
  static const String baseUrl = "https://keidot.azurewebsites.net/api/Locations/assignmentLocation"; 
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger();

  Future<LocationModel?> fetchLocation() async {
    try {
      // Obtener el assignmentId desde el controlador
      final AssignmentIdController assignmentController = Get.find<AssignmentIdController>();
      String? assignmentId = assignmentController.selectedAssignmentId;

      if (assignmentId == null || assignmentId.isEmpty) {
        logger.w("Assignment ID no encontrado o vacío.");
        return null;
      }

      // Obtener el token de autenticación
      String? token = await storage.read(key: "token");
      if (token == null) {
        logger.w("Token no encontrado en el almacenamiento seguro.");
        return null;
      }

      String url = "$baseUrl/$assignmentId";
      logger.i("📤 Realizando solicitud GET a: $url");
      logger.d("🔑 Token recuperado: $token");

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      logger.i("📥 Respuesta recibida con código ${response.statusCode}");

      if (response.statusCode == 200) {
        logger.d("✅ Datos de ubicación recibidos correctamente.");
        return LocationModel.fromJson(json.decode(response.body));
      } else {
        logger.e("❌ Error al obtener la ubicación: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e, stackTrace) {
      logger.e("⚠️ Excepción durante la solicitud: $e", error: e, stackTrace: stackTrace);
      return null;
    }
  }
}
