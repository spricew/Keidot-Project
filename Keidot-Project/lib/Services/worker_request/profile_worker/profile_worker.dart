import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/models/worker_profile.dart';

class ProfileWorkerService {
  final String baseUrl = 'https://tu-api.com/api'; // Ajusta tu URL base
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger();

  Future<ProfileWorkerDTO?> getProfileWorkerById(String workerId) async {
    try {
     String? token = await storage.read(key: "token");

      if (token == null) {
        logger.w("Token no encontrado en el almacenamiento seguro.");
        return null;
      }
      final response = await http.get(
        Uri.parse('$baseUrl/profiles/worker/$workerId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return ProfileWorkerDTO.fromJson(data);
      } else {
        throw Exception('Error al obtener el perfil: ${response.statusCode}');
      }
    } catch (e) {
      logger.e("Error durante la solicitud: $e");
      return null;
    }
  }
}
