import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class ReviewWorkerService {
  final String baseUrl = 'https://keidot.azurewebsites.net/api/Reviews/worker';
  final Logger logger = Logger();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  
 Future<List<Map<String, dynamic>>?> fetchReview() async {
  try {
    String? workerId = await storage.read(key: "userId");
    
    if (workerId == null) {
      logger.e("Error: No se encontró el ID del trabajador en el almacenamiento");
      return null;
    }

    String? token = await storage.read(key: "token");
    final response = await http.get(
      Uri.parse('$baseUrl/$workerId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      logger.i("Reseñas obtenidas correctamente: $data");

      return data.cast<Map<String, dynamic>>(); // Convertir List<dynamic> a List<Map<String, dynamic>>
    } else {
      logger.e("Error al obtener reseñas: ${response.body}");
      return null;
    }
  } catch (e) {
    logger.e("Error en la solicitud: $e");
    return null;
  }
}
}
