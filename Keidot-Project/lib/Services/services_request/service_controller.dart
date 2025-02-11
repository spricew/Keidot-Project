import 'package:get/get.dart';
import 'package:test_app/Services/models/service_model.dart';
import 'package:test_app/Services/services_request/service_get_request.dart';

class ServiceController extends GetxController {
  var services = <Service>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchServices();
    super.onInit();
  }

  Future<void> fetchServices() async {
    try {
      isLoading.value = true;
      var apiServices = await ApiService.fetchServices();
      services.assignAll(apiServices);
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
