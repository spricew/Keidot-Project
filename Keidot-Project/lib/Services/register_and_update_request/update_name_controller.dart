import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UpdateNameProfile {
  final String baseUrl = 'https://keidot.azurewebsites.net/api/UpdateProfiles'; // Reemplázalo con tu URL
  final FlutterSecureStorage storage = FlutterSecureStorage();

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
    String? userId = await getUserId();
    String? token = await getToken();

    if (userId == null || token == null) {
      print("Error: No se encontró el ID del usuario o el token.");
      return false;
    }

    final url = Uri.parse('$baseUrl/OnlyName/$userId');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"fullname": newName}),
    );

    if (response.statusCode == 200) {
      print("Nombre actualizado correctamente");
      return true;
    } else {
      print("Error al actualizar el nombre: ${response.body}");
      return false;
    }
  }
}
