import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/Services/models/location_model.dart';

class LocationService {
  static const String baseUrl = "https://tu-api.com/api/location";  // Reemplaza con tu URL real

  Future<LocationModel?> fetchLocation(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/$userId'));

    if (response.statusCode == 200) {
      return LocationModel.fromJson(json.decode(response.body));
    } else {
      print("Error al obtener la ubicación: ${response.body}");
      return null;
    }
  }
}
