import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/Services/models/location_model.dart';

class LocationService {
  final String apiUrl = 'https://tuapi.com/guardar_ubicacion';
  final storage = const FlutterSecureStorage();

  /// Obtiene el UserId y Token del almacenamiento seguro.
  Future<Map<String, String>> _getAuthData() async {
    String? userId = await storage.read(key: 'userId');
    String? token = await storage.read(key: 'token');

    if (userId == null || token == null) {
      throw Exception("Usuario no autenticado o token no disponible");
    }
    return {'userId': userId, 'token': token};
  }

  /// Guarda la ubicación en la API.
  Future<void> saveLocation(double latitude, double longitude) async {
    try {
      final authData = await _getAuthData(); // Obtener credenciales
      LocationModel location = LocationModel(
        userId: authData['userId']!,
        latitude: latitude,
        longitude: longitude,
      );

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${authData['token']}",
        },
        body: jsonEncode(location.toJson()),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Éxito", "Ubicación guardada con éxito",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        final errorMessage = jsonDecode(response.body)['message'] ?? "Error desconocido";
        Get.snackbar("Error", errorMessage, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "Error al guardar ubicación: $e",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

class LocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = false.obs; // Para manejar estado de carga

  void setLocation(double lat, double lng) {
    latitude.value = lat;
    longitude.value = lng;
  }

  void clearLocation() {
    latitude.value = 0.0;
    longitude.value = 0.0;
  }

  /// Guarda la ubicación usando el servicio y maneja el estado de carga
  Future<void> saveLocation() async {
    isLoading.value = true;
    await LocationService().saveLocation(latitude.value, longitude.value);
    isLoading.value = false;
  }
}
