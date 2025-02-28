import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:test_app/presentation/screens/login_screen.dart';
import 'dart:convert';
import '../models/user_model.dart';

class RegisterService {
  final String baseUrl = 'https://keidot.azurewebsites.net/api/RegisterUsers';
  final Logger logger = Logger();

  Future<Map<String, dynamic>?> register(BuildContext context, UserModel user) async {
  try {
    final String requestBody = jsonEncode(user.toJson());
    logger.i("Enviando solicitud de registro: $requestBody");

    final response = await http
        .post(
          Uri.parse(baseUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: requestBody,
        )
        .timeout(const Duration(seconds: 10));

    logger.i("Código de estado: ${response.statusCode}");
    logger.i("Respuesta del servidor: ${response.body}");

    if (!context.mounted) return null;

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      });
      return null; // No hay errores, el registro fue exitoso
    } else if (response.statusCode == 400) {
      // Capturar errores de validación
      final Map<String, dynamic> errorData = jsonDecode(response.body);
      if (errorData.containsKey('errors')) {
        return errorData['errors']; // Retornar los errores al método que llamó
      }
    }

    // Error genérico
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error en el registro. Inténtalo de nuevo.')),
    );
    return {"general": ["Error en el registro"]}; // Retornar un error genérico
  } catch (e) {
    logger.e("Excepción en el registro: $e");

    if (!context.mounted) return null;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error de conexión: $e')),
    );
    return {"general": ["Error de conexión"]}; // Retornar error de conexión
  }
} //Register method
}
