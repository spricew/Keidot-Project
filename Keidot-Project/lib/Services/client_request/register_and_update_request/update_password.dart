import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class UpdatePassword {
  final String baseUrl = "https://keidot.azurewebsites.net/api/RegisterUsers"; // Reemplaza con la URL de tu API
  final storage = const FlutterSecureStorage();
  final Logger logger = Logger();

  /// Obtiene el ID del usuario autenticado desde el almacenamiento seguro
  Future<String?> getUserId() async {
    return await storage.read(key: 'userId');
  }

  /// Obtiene el token de autenticación desde el almacenamiento seguro
  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  /// 🔹 **Actualizar contraseña**
  Future<bool> updatePassword(String newPassword) async {
    try {
      // Recuperar userId y token del almacenamiento seguro
      String? userId = await getUserId();
      String? token = await getToken();

      if (userId == null || token == null) {
        logger.e("No se encontró el usuario autenticado.");
        throw Exception("No se encontró el usuario autenticado.");
      }

      final url = Uri.parse("$baseUrl/UpdatePassword/$userId");
      logger.d("Enviando solicitud PUT a: $url");

      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"newPassword": newPassword}),
      );

      if (response.statusCode == 200) {
        logger.i("Contraseña actualizada con éxito.");
        return true;
      } else {
        logger.e("Error al actualizar contraseña: ${response.body}");
        return false;
      }
    } catch (e) {
      logger.e("Excepción al actualizar la contraseña: $e");
      return false;
    }
  }
}
