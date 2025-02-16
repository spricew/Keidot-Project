import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ServiceTransactionController extends GetxController {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // Variables observables para los campos del formulario
  var userId = ''.obs;
  var serviceId = ''.obs;
  var description = ''.obs;
  var amount = 110.0.obs;
  var tiempoEstimado = Duration.zero.obs;
  var selectedTime = ''.obs;

  // Cargar el userId desde almacenamiento seguro al iniciar
  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    userId.value = await storage.read(key: 'userId') ?? "";
  }

  // Métodos para actualizar los campos
  void setUserId(String id) => userId.value = id;
  void setServiceId(String id) => serviceId.value = id;
  void setDescription(String desc) => description.value = desc;
  void setAmount(double amt) => amount.value = amt;
  void setTiempoEstimado(Duration duration) => tiempoEstimado.value = duration;
  void setSelectedTime(String time) => selectedTime.value = time;

  // Método para enviar la solicitud al servidor
  Future<void> sendRequest() async {
    final token = await storage.read(key: 'token');

    if (userId.value.isEmpty || serviceId.value.isEmpty || token == null) {
      Get.snackbar("Error", "Todos los campos son obligatorios");
      return;
    }

    final requestData = {
      "userId": userId.value,
      "serviceId": serviceId.value,
      "description": description.value,
      "amount": amount.value,
      "tiempoEstimado": tiempoEstimado.value.inMinutes, // Convertir a minutos
      "selectedTime": selectedTime.value,
    };
    
    try {
      print("Enviando solicitud: ${jsonEncode(requestData)}");
      final response = await http.post(
        Uri.parse('https://keidot.azurewebsites.net/api/ServiceRequest/create'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // Enviar token en los headers
        },
        body: jsonEncode(requestData),
      );


      if (response.statusCode == 200) {
        print("Solicitud enviada con éxito");
        Get.snackbar("Éxito", "La solicitud se envió correctamente");
      } else {
        print("Error al enviar la solicitud: ${response.statusCode}");
        print("Respuesta del servidor: ${response.body}");
        Get.snackbar(
            "Error", "No se pudo enviar la solicitud: ${response.body}");
      }
    } catch (e) {
      print("Excepción al enviar la solicitud: $e");
      Get.snackbar("Error", "Error de conexión: $e");
    }
  }
}
