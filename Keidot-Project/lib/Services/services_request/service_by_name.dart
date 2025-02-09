import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/Services/login_request/auth_serviceController.dart';

class ApiServiceName {
  static const String baseUrl = "https://keidot.azurewebsites.net/api/Service";
//https://keidot.azurewebsites.net/
  Future<Map<String, dynamic>?> getServiceByName(String query) async {
    try {
      final String? token = await AuthService().getToken(); // Obtener token

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
        
        // Convertir el query a minúsculas
        String queryLower = query.toLowerCase();

        // Buscar en la lista ignorando mayúsculas/minúsculas
        var matchedService = jsonData.firstWhere(
          (service) => service['title'].toString().toLowerCase() == queryLower,
          orElse: () => null,
        );

        return matchedService;
      } else {
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error inesperado: $e");
    }
  }
}
