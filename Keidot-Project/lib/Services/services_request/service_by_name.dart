import 'package:dio/dio.dart';

class ApiServiceName {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> getServiceByName(String title) async {
    try {
      final response = await _dio.get(
        "https://keidotapp.azurewebsites.net/api/Service/by-name",
        queryParameters: {"title": title},
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      print("Error al obtener servicio: $e");
      return null;
    }
  }
}
