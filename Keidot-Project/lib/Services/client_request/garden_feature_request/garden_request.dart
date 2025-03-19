import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:test_app/Services/models/garden_feature_model.dart';

class GardenFeatureService {
  final String baseUrl = "https://keidotapi.azurewebsites.net/api"; // Base URL
  final Logger logger = Logger(); // Inicializar Logger
  final FlutterSecureStorage storage = const FlutterSecureStorage(); // Almacenamiento seguro

  // Obtener todas las características del jardín
  Future<List<GardenFeature>> fetchFeatures() async {
    try {
      // Obtener token desde el almacenamiento seguro
      String? token = await storage.read(key: "token");

      if (token == null) {
        logger.e("Error: No se encontró un token de autenticación.");
        throw Exception("No se encontró un token de autenticación");
      }

      // Configurar headers con el token
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      // Realizar la solicitud GET
      final response = await http.get(
        Uri.parse('$baseUrl/garden-features'),
        headers: headers,
      );

      // Registrar la respuesta
      logger.i("Respuesta del servidor (${response.statusCode}): ${response.body}");

      // Verificar si la respuesta es exitosa
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => GardenFeature.fromJson(e)).toList();
      } else {
        logger.e("Error al cargar características: ${response.statusCode}");
        throw Exception("Error al cargar características");
      }
    } catch (e) {
      logger.e("Excepción al obtener características: $e");
      throw Exception("Error de conexión: $e");
    }
  }
}
