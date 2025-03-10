import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:test_app/presentation/worker/map_screen.dart';

class LocationService {
  static const String baseUrl = "https://keidot.azurewebsites.net/api/Locations/assignmentLocation"; 
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger(); 

  Future<void> fetchAndNavigateToLocation(String assignmentId) async {
    try {
      String? token = await storage.read(key: "token");

      if (token == null) {
        logger.w("Token no encontrado en el almacenamiento seguro.");
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/$assignmentId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        double latitude = data['latitude'];
        double longitude = data['longitude'];

        logger.i("Ubicación obtenida: lat=$latitude, lon=$longitude");

        // Navegar a la pantalla del mapa con la ubicación obtenida
        Get.to(() => MapScreen(latitude: latitude, longitude: longitude));
      } else {
        logger.e("Error al obtener la ubicación: ${response.body}");
      }
    } catch (e, stackTrace) {
      logger.e("Excepción durante la solicitud: $e", error: e, stackTrace: stackTrace);
    }
  }
}
