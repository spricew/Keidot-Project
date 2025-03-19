import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class DeviceTokenService {
  static const String apiUrl = "https://keidotapi.azurewebsites.net/api/DeviceToken/update"; // Cambia por tu URL
  static const FlutterSecureStorage storage = FlutterSecureStorage();
  static final Logger logger = Logger(); // Instancia de Logger

  static Future<String?> getDeviceToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      logger.i("Token de dispositivo obtenido: $token"); // Log informativo
      return token;
    } catch (e, stacktrace) {
      logger.e("Error al obtener el token de dispositivo", error: e, stackTrace: stacktrace); // Log de error con stacktrace
      return null;
    }
  }

  static Future<void> sendDeviceToken() async {
    try {
      String? userId = await storage.read(key: 'userId');
      String? deviceToken = await getDeviceToken();

      if (userId == null || deviceToken == null) {
        logger.w("No se pudo obtener userId o deviceToken."); // Warning log
        return;
      }

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "deviceToken": deviceToken,
        }),
      );

      if (response.statusCode == 200) {
        logger.i("Device Token actualizado correctamente"); // Info log
      } else {
        logger.e("Error al actualizar Device Token: ${response.body}"); // Error log
      }
    } catch (e, stacktrace) {
      logger.e("Error al enviar Device Token", error: e, stackTrace: stacktrace); // Error log con stacktrace
    }
  }
}
