import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/Services/models/location_model.dart';

class LocationService {
  final String apiUrl = 'https://tuapi.com/guardar_ubicacion';
  final storage = const FlutterSecureStorage();

  Future<void> saveLocation(double latitude, double longitude) async {
    try {
      // Recuperar userId y token del almacenamiento seguro
      String? userId = await storage.read(key: 'userId');
      String? token = await storage.read(key: 'token');

      if (userId == null || token == null) {
        throw Exception("Usuario no autenticado o token no disponible");
      }

      // Crear el objeto de ubicación
      LocationModel location = LocationModel(
        userId: userId,
        latitude: latitude,
        longitude: longitude,
      );

      // Enviar la solicitud POST con el token en los headers
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Se añade el token
        },
        body: jsonEncode(location.toJson()),
      );

      if (response.statusCode == 200) {
        print("Ubicación guardada con éxito");
      } else {
        print("Error al guardar ubicación: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
