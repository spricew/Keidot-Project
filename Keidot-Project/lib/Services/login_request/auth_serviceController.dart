import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/client_request/assignment_request/GET/assignment_in_pending.dart';
import 'package:test_app/Services/client_request/assignment_request/GET/assignment_in_wait.dart';
import 'package:test_app/Services/client_request/review_request/review_controller.dart';
import 'package:test_app/Services/client_request/transaction/service_transaction_controller.dart';
import 'package:test_app/Services/firebase_messaging/device_token.dart';
import 'package:test_app/Services/worker_request/reviews_request/review_controllerGet.dart';
import 'package:test_app/fireBaseExampleScreen.dart';
import 'package:test_app/presentation/screens/home_page.dart';
import 'package:test_app/presentation/screens/login_screen.dart';

class AuthenticationService {
  final String baseUrl = 'https://keidot.azurewebsites.net/api/Login/login';
  static const FlutterSecureStorage storage = FlutterSecureStorage();
  final Logger logger = Logger();

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      logger.i("Iniciando sesión para: $email");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        logger.i("ID recibido del backend: ${data['id']}");
        logger.i("Token recibido: ${data['token']}");

        // Eliminar datos anteriores
        await Future.wait([
          storage.delete(key: 'userId'),
          storage.delete(key: 'token'),
          storage.delete(key: 'name'),
        ]);

        // Guardar nuevos datos
        await Future.wait([
          storage.write(key: 'userId', value: data['id']),
          storage.write(key: 'token', value: data['token']),
          storage.write(key: 'name', value: data['name'] ?? ''),
        ]);

        // Verificar que el ID realmente se guardó
        String? userIdStored = await storage.read(key: "userId");
        logger.i("User ID almacenado después del login: $userIdStored");

        // Enviar Device Token al backend
        await DeviceTokenService.sendDeviceToken();

        // Resetear controladores con el nuevo usuario
        Get.delete<ServiceTransactionController>();
        Get.put(ServiceTransactionController());

        Get.delete<ReviewController>();
        Get.put(ReviewController());

        Get.delete<AssignmentInWait>();
        Get.put(AssignmentInWait());

        // Navegar a la pantalla principal
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      } else {
        logger.e("Error en inicio de sesión: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales incorrectas')),
        );
      }
    } catch (e) {
      logger.e("Error al iniciar sesión: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al iniciar sesión')),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    logger.i("Cerrando sesión...");
    await storage.delete(key: 'token');
    await storage.delete(key: 'userId');
    await storage.delete(key: 'name');
    logger.i("Credenciales eliminadas correctamente");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<String?> getUserId() async {
    return await storage.read(key: 'userId');
  }

  Future<String?> getUserName() async {
    return await storage.read(key: 'name');
  }
}
