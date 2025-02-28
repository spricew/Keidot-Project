import 'dart:convert';
import 'dart:io';

class FileConverter {
  /// Convierte un archivo en una cadena Base64
  static Future<String> convertToBase64(File file) async {
    List<int> fileBytes = await file.readAsBytes();
    return base64Encode(fileBytes);
  }
}
