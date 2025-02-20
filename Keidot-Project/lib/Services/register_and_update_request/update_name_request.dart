import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class UpdateNameProfile {
  final String baseUrl = 'https://keidot.azurewebsites.net/api/UpdateProfiles';
  static const FlutterSecureStorage storage = FlutterSecureStorage();
  final Logger logger = Logger();

  /// Obtiene el ID del usuario autenticado desde el almacenamiento seguro
  Future<String?> getUserId() async {
    return await storage.read(key: 'userId');
  }

  /// Obtiene el token de autenticación desde el almacenamiento seguro
  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  /// Actualiza solo el nombre del usuario
  Future<bool> updateUserName(String newName) async {
    try {
      String? userId = await getUserId();
      String? token = await getToken();

      if (userId == null || token == null) {
        logger.e("Error: No se encontró el ID del usuario o el token.");
        return false;
      }

      final url = Uri.parse('$baseUrl/OnlyName/$userId');
      logger.i("URL de la solicitud: $url");
      logger.d("Enviando nombre actualizado: $newName");

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"fullname": newName}),
      );

      if (response.statusCode == 200) {
        logger.i("Nombre actualizado correctamente");
        return true;
      } else {
        logger.e("Error al actualizar el nombre: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      logger.e("Excepción al actualizar el nombre: $e");
      return false;
    }
  }
}