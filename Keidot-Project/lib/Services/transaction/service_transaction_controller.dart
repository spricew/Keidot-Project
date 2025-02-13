import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_app/Services/models/service_transaction_model.dart';

class ServiceTransactionController extends GetxController {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  var requestData = ServiceTransactionModel(
    userId: "",
    serviceId: "",
    description: "",
    amount: 110.0,
    tiempoEstimado: Duration.zero,
    selectedTime: "",
  ).obs;

  // Métodos para actualizar los campos de la solicitud
  void setUserId(String id) => requestData.update((val) => val?.userId = id);
  void setServiceId(String serviceId) => requestData.update((val) => val?.serviceId = serviceId);
  void setDescription(String desc) => requestData.update((val) => val?.description = desc);
  void setAmount(double amt) => requestData.update((val) => val?.amount = amt);
  void setTiempoEstimado(Duration duration) => requestData.update((val) => val?.tiempoEstimado = duration);
  void setSelectedTime(String time) => requestData.update((val) => val?.selectedTime = time);

  // Método para enviar la solicitud al servidor
Future<void> sendRequest() async {
  // Recupera el ID del usuario y el token desde el almacenamiento seguro
  final userId = await storage.read(key: 'userId');
  final token = await storage.read(key: 'token');

  if (userId == null || token == null) {
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
      requestData.value.serviceId.isEmpty) {
    Get.snackbar("Error", "Todos los campos son obligatorios");
    return;
  }

  // Añade el token en el cuerpo de la solicitud
  final jsonData = jsonEncode({
    ...requestData.value.toJson(), // Datos actuales de la solicitud
    "token": token, // Se agrega el token al JSON
  });

  print("JSON enviado: $jsonData"); // Para depuración

  try {
    final response = await http.post(
      Uri.parse('https://keidot.azurewebsites.net/api/ServiceRequest/create'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonData,
    );

    if (response.statusCode == 200) {
      print("Solicitud enviada con éxito");
      Get.snackbar("Éxito", "La solicitud se envió correctamente");
    } else {
      print("Error al enviar la solicitud: ${response.statusCode}");
      print("Respuesta del servidor: ${response.body}");
      Get.snackbar("Error", "No se pudo enviar la solicitud: ${response.body}");
    }
  } catch (e) {
    print("Excepción al enviar la solicitud: $e");
    Get.snackbar("Error", "Error de conexión: $e");
  }
}

}