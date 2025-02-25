import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/Services/models/garden_feature.dart';

class GardenFeatureService {
  final String baseUrl = "https://tu-api.com/api"; // Cambia esto por tu URL real

  // Obtener todas las características
  Future<List<GardenFeature>> fetchFeatures() async {
    final response = await http.get(Uri.parse('$baseUrl/garden-features'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => GardenFeature.fromJson(e)).toList();
    } else {
      throw Exception("Error al cargar características");
    }
  }
}
//Solo necesito que se muestre la lista para obtener los ids de las caracteristicas seleccionadas y se vayan guardando en el controlador
//para posteriormente enviarlo a la api
//dase => cuenta