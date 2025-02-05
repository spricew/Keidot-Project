import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_app/Services/models/service_transaction_model.dart';

class ServiceTransactionController extends GetxController {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  var requestData = ServiceTransactionModel(
    userId: "",
    serviceId: "829da46a-b386-4b3d-9b1c-66cf3b317f07",
    paymentMethodId: "",
    description: "",
    amount: 110.0,
    tiempoEstimado: Duration.zero,
    selectedTime: "",
  ).obs;

  // Métodos para actualizar los campos de la solicitud
  void setUserId(String id) => requestData.update((val) => val?.userId = id);
  void setServiceId(String id) => requestData.update((val) => val?.serviceId = id);
  void setPaymentMethod(String id) => requestData.update((val) => val?.paymentMethodId = id);
  void setDescription(String desc) => requestData.update((val) => val?.description = desc);
  void setAmount(double amt) => requestData.update((val) => val?.amount = amt);
  void setTiempoEstimado(Duration duration) => requestData.update((val) => val?.tiempoEstimado = duration);
  void setSelectedTime(String time) => requestData.update((val) => val?.selectedTime = time);

  // Método para enviar la solicitud al servidor
  Future<void> sendRequest() async {
    // Recupera el ID del usuario desde el almacenamiento seguro
    final userId = await storage.read(key: 'userId');
    if (userId == null) {
      Get.snackbar("Error", "Usuario no autenticado");
      return;
    }

    // Asigna el ID del usuario a la solicitud
    setUserId(userId);

    // Verifica que la duración sea válida
    if (requestData.value.tiempoEstimado.inHours <= 0) {
      Get.snackbar("Error", "Selecciona una duración válida");
      return;
    }

    // Verifica que los campos obligatorios no estén vacíos
    if (requestData.value.userId.isEmpty ||
        requestData.value.serviceId.isEmpty ||
        requestData.value.paymentMethodId.isEmpty) {
      Get.snackbar("Error", "Todos los campos son obligatorios");
      return;
    }

    // Convierte el modelo a JSON
    final jsonData = jsonEncode(requestData.value.toJson());
    print("JSON enviado: $jsonData"); // Imprime el JSON para depuración

    try {
      final response = await http.post(
        Uri.parse('https://keidotapp.azurewebsites.net/api/ServiceRequest/create'),
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        // Manejar respuesta exitosa
        print("Solicitud enviada con éxito");
        Get.snackbar("Éxito", "La solicitud se envió correctamente");
      } else {
        // Manejar error
        print("Error al enviar la solicitud: ${response.statusCode}");
        print("Respuesta del servidor: ${response.body}"); // Imprime la respuesta del servidor
        Get.snackbar("Error", "No se pudo enviar la solicitud: ${response.body}");
      }
    } catch (e) {
      // Manejar excepciones (por ejemplo, problemas de conexión)
      print("Excepción al enviar la solicitud: $e");
      Get.snackbar("Error", "Error de conexión: $e");
    }
  }
}