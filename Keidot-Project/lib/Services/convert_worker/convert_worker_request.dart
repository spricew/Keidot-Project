import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_app/Services/models/convert_worker_model.dart';
import 'package:logger/logger.dart';

class UserProfileController {
  final String baseUrl = "https://keidot.azurewebsites.net/api/UpdateProfiles";
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger(); // Inicializar logger

  Future<bool> updateUserProfile(UserProfile userProfile) async {
    try {
      // Obtener credenciales
      String? userId = await storage.read(key: "userId");
      String? token = await storage.read(key: "token");

      if (userId == null || token == null) {
        logger.e("No se encontró el ID de usuario o el token.");
        throw Exception("No se encontró el ID de usuario o el token.");
      }

      final url = Uri.parse("$baseUrl/$userId");
      final body = jsonEncode(userProfile.toJson());
      
      logger.i("Enviando solicitud PUT a: $url");
      logger.d("Body: $body");

      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      logger.i("Respuesta recibida: ${response.statusCode}");
      logger.d("Respuesta: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 204) {
        logger.i("Perfil actualizado exitosamente.");
        return true;
      } else {
        logger.e("Error al actualizar perfil: ${response.body}");
        return false;
      }
    } catch (e) {
      logger.e("Excepción en updateUserProfile: $e");
      return false;
    }
  }
}
