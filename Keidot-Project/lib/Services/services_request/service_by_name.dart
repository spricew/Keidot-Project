import 'package:get/get.dart';
import 'package:test_app/Services/models/service_model.dart';
import 'package:test_app/Services/services_request/service_controller.dart';

class ApiServiceName {
  final ServiceController serviceController = Get.find<ServiceController>();

  Future<List<Map<String, dynamic>>> getServicesByName(String query) async {
    try {
      String queryLower = query.toLowerCase();

      // Filtrar todos los servicios que contengan el query en su título
      List<Service> matchedServices = serviceController.services.where((service) {
        return service.title.toLowerCase().contains(queryLower);
      }).toList();

      // Convertir los objetos a JSON
      return matchedServices.map((service) => service.toJson()).toList();
    } catch (e) {
      throw Exception("Error inesperado: $e");
    }
  }
}
