import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class FileUploader {
  static const String apiUrl =
      'https://keidot.azurewebsites.net/api/ImageService/Upload'; // Reemplaza con la URL real

  static final Logger _logger = Logger(); // Instancia de Logger

  /// Envía la imagen Base64 al servidor y devuelve la URL
  static Future<String?> uploadImage(String base64Image, String fileName) async {
    try {
      _logger.i("Iniciando carga de imagen: $fileName"); // Info log

      if (base64Image.isEmpty || fileName.isEmpty) {
        _logger.e(
            "Error: La imagen en Base64 o el nombre del archivo están vacíos.");
        return null;
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "Nombre": fileName, 
          "Base64": base64Image, 
        }),
      );

      _logger.i(
          "Respuesta del servidor: ${response.statusCode}, ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _logger.i("Imagen subida con éxito. URL: ${data["imageUrl"]}");
        return data["imageUrl"]; // Retorna la URL de la imagen
      } else {
        _logger.w(
            "Error en la respuesta del servidor. Código: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      _logger.e("Error al subir la imagen", error: e);
      return null;
    }
  }
}
