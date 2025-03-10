import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FileUploader {
  static const String apiUrl =
      'https://keidot.azurewebsites.net/api/ImageService/Upload'; // URL de la API

  static final Logger _logger = Logger(); // Instancia de Logger
  static const FlutterSecureStorage storage = FlutterSecureStorage(); // Agregado

  /// Envía la imagen Base64 al servidor y devuelve la URL
  static Future<String?> uploadImage(String base64Image, String fileName) async {
    try {
      _logger.i("Iniciando carga de imagen: $fileName");

      if (base64Image.isEmpty || fileName.isEmpty) {
        _logger.e("Error: La imagen en Base64 o el nombre del archivo están vacíos.");
        return null;
      }

      final token = await storage.read(key: 'token'); // 🔹 Ahora sí existe

      if (token == null) {
        _logger.e("Error: Token no encontrado.");
        return null;
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // 🔹 Se usa el token correctamente
        },
        body: jsonEncode({
          "Nombre": fileName,
          "Base64": base64Image,
        }),
      );

      _logger.i("Respuesta del servidor: ${response.statusCode}, ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _logger.i("Imagen subida con éxito. URL: ${data["imageUrl"]}");
        return data["imageUrl"]; // Retorna la URL de la imagen
      } else {
        _logger.w("Error en la respuesta del servidor. Código: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      _logger.e("Error al subir la imagen", error: e);
      return null;
    }
  }
}
