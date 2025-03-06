import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/models/service_transaction_model.dart';
import 'package:test_app/Services/models/location_model.dart';

class ServiceTransactionController extends GetxController {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger();

  var transaction = ServiceTransactionModel(
    userId: '',
    serviceId: '',
    description: '',
    amount: 110.0,
    estimatedSize: '',
    selectedTime: '',
    featureIds: [],
    latitude: 0.0,
    longitude: 0.0,
  ).obs;
  var serviceName = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    String? userIdStored = await storage.read(key: 'userId');
    String? serviceIdStored = await storage.read(key: 'serviceId');

    transaction.update((val) {
      if (val != null) {
        val.userId = userIdStored ?? "";
        val.serviceId = serviceIdStored ?? "";
      }
    });
    logger.i("Usuario y servicio cargados: userId=$userIdStored, serviceId=$serviceIdStored");
  }

  void setService(String id, String name) {
    transaction.update((val) {
      if (val != null) {
        val.serviceId = id;
      }
    });
    serviceName.value = name;
    logger.i("Servicio seleccionado: $name (ID: $id)");
  }

  void setDescription(String desc) {
    transaction.update((val) {
      if (val != null) val.description = desc;
    });
    logger.i("Descripción actualizada: $desc");
  }

  void setAmount(double amt) {
    transaction.update((val) {
      if (val != null) val.amount = amt;
    });
    logger.i("Monto actualizado: \$${amt.toStringAsFixed(2)}");
  }

  void setEstimatedSize(String size) {
    transaction.update((val) {
      if (val != null) val.estimatedSize = size;
    });
    logger.i("Tamaño estimado actualizado: $size");
  }

  void setSelectedTime(String date) {
    transaction.update((val) {
      if (val != null) val.selectedTime = date;
    });
    logger.i("Fecha seleccionada: $date");
  }

  void setFeatureIds(List<String> selectedFeatures) {
    transaction.update((val) {
      if (val != null) val.featureIds = selectedFeatures;
    });
    logger.i("Características seleccionadas: $selectedFeatures");
  }

  void setLocation(double lat, double lng) {
    transaction.update((val) {
      if (val != null) {
        val.latitude = lat;
        val.longitude = lng;
      }
    });
    logger.d("Ubicación establecida: lat=$lat, lng=$lng");
  }


  Future<void> sendRequest() async {
    final token = await storage.read(key: 'token');

    if (transaction.value.userId.isEmpty ||
        transaction.value.serviceId.isEmpty ||
        transaction.value.description.isEmpty ||
        transaction.value.selectedTime.isEmpty ||
        token == null) {
      logger.w("Error: Faltan datos obligatorios para enviar la solicitud.");
      Get.snackbar("Error", "Todos los campos son obligatorios");
      return;
    }
     
    final requestData = transaction.value.toJson();

    try {
      if (token.isEmpty) {
        logger.e("Error: El token de autenticación no está definido.");
        return;
      }

      logger.i("Enviando solicitud: ${jsonEncode(requestData)}");

      final response = await http.post(
        Uri.parse('https://keidot.azurewebsites.net/api/ServiceRequest/create'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        logger.i("Solicitud enviada con éxito.");
        Get.snackbar("Éxito", "La solicitud se envió correctamente");
      } else {
        logger.e("Error al enviar la solicitud: ${response.statusCode}, Respuesta: ${response.body}");
        Get.snackbar("Error", "No se pudo enviar la solicitud: ${response.body}");
      }
    } catch (e) {
      logger.e("Excepción al enviar la solicitud: $e");
      Get.snackbar("Error", "Error de conexión: $e");
    }
  }
}
