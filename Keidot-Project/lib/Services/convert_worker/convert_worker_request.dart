import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_app/Services/models/convert_worker_model.dart';

class UserProfileController {
  final String baseUrl = "https://keidot.azurewebsites.net/api/UpdateProfiles";
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<bool> updateUserProfile(UserProfile userProfile) async {
    try {
      // Obtener ID de usuario y token desde el almacenamiento seguro
      String? userId = await storage.read(key: "userId"); // Corregido
      String? token = await storage.read(key: "token");   // Corregido

      if (userId == null || token == null) {
        throw Exception("No se encontró el ID de usuario o token.");
      }

      final url = Uri.parse("$baseUrl/$userId");

      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(userProfile.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true; // Éxito en la actualización
      } else {
        print("Error al actualizar perfil: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Excepción en updateUserProfile: $e");
      return false;
    }
  }
}
