import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:test_app/Services/login_request/auth_serviceController.dart';
import 'package:test_app/Services/models/service_model.dart';

class ApiService {
  static const String baseUrl = "https://keidot.azurewebsites.net/api/Service";

  static Future<List<Service>> fetchServices() async {
    try {
      final String? token = await AuthService().getToken(); // Obtiene el token

      if (token == null) {
        throw Exception("No se encontró el token. Inicia sesión nuevamente.");
      }

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => Service.fromJson(item)).toList();
      } else {
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
    } on SocketException {
      throw Exception("No hay conexión a Internet");
    } on FormatException {
      throw Exception("Error al decodificar la respuesta del servidor");
    } on HttpException {
      throw Exception("Error en la solicitud HTTP");
    } on TimeoutException {
      throw Exception("La solicitud tardó demasiado en responder");
    } catch (e) {
      throw Exception("Error inesperado: $e");
    }
  }
}
