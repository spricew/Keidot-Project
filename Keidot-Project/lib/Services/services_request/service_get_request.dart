import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:test_app/Services/login_request/auth_serviceController.dart';
import 'package:test_app/Services/models/service_model.dart';

class ApiService {
  static const String baseUrl = "https://keidot.azurewebsites.net/api/Service";
  static final Logger logger = Logger();

  static Future<List<Service>> fetchServices() async {
    try {
      final String? token = await AuthService().getToken(); // Obtiene el token
      
      if (token == null) {
        logger.e("No se encontró el token. Inicia sesión nuevamente.");
        throw Exception("No se encontró el token. Inicia sesión nuevamente.");
      }

      logger.i("🔍 Token recuperado: $token");
      logger.i("🌍 Realizando petición GET a: $baseUrl");

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      logger.i("📥 Respuesta recibida: ${response.statusCode}");
      
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        logger.i("✅ Servicios obtenidos correctamente (${jsonData.length} elementos)");
        return jsonData.map((item) => Service.fromJson(item)).toList();
      } else {
        logger.e("❌ Error ${response.statusCode}: ${response.body}");
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
    } on SocketException {
      logger.e("No hay conexión a Internet");
      throw Exception("No hay conexión a Internet");
    } on FormatException {
      logger.e("Error al decodificar la respuesta del servidor");
      throw Exception("Error al decodificar la respuesta del servidor");
    } on HttpException {
      logger.e("Error en la solicitud HTTP");
      throw Exception("Error en la solicitud HTTP");
    } on TimeoutException {
      logger.e("La solicitud tardó demasiado en responder");
      throw Exception("La solicitud tardó demasiado en responder");
    } catch (e) {
      logger.e("Error inesperado: $e");
      throw Exception("Error inesperado: $e");
    }
  }
}
