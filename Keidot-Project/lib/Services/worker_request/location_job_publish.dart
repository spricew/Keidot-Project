import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/Services/models/location_model.dart';
import 'package:logger/logger.dart';

class LocationService {
  static const String baseUrl = "https://tu-api.com/api/location"; 
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger(); // Instancia del Logger

  Future<LocationModel?> fetchLocation(String userId) async {
    try {
      String? token = await storage.read(key: "token");

      if (token == null) {
        logger.w("Token no encontrado en el almacenamiento seguro.");
        return null;
      }

      logger.i("Realizando solicitud GET a: $baseUrl/$userId");
      logger.d("Token recuperado: $token");

      final response = await http.get(
        Uri.parse('$baseUrl/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      logger.i("📥 Respuesta recibida con código ${response.statusCode}");

      if (response.statusCode == 200) {
        logger.d("Datos recibidos correctamente.");
        return LocationModel.fromJson(json.decode(response.body));
      } else {
        logger.e("Error al obtener la ubicación: ${response.body}");
        return null;
      }
    } catch (e, stackTrace) {
      logger.e("Excepción durante la solicitud: $e", error: e, stackTrace: stackTrace);
      return null;
    }
  }
}
