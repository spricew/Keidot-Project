import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/presentation/screens/login_screen.dart';
import 'dart:convert';
import '../models/user_model.dart';

class RegisterService {
  final String baseUrl = 'https://keidot.azurewebsites.net/api/RegisterUsers';
  
  Future<void> register(BuildContext context, UserModel user) async {
  try {
    final String requestBody = jsonEncode(user.toJson());

    print("Body enviado: $requestBody"); // 👀 Imprimir el JSON antes de enviarlo

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: requestBody,
    ).timeout(const Duration(seconds: 10)); // ⏳ Agregamos timeout

    print("Código de estado: ${response.statusCode}");
    print("Respuesta del servidor: ${response.body}");

    if (!context.mounted) return; // Evita usar context si no está montado

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );

      // Redirige a Login después de 2 segundos
      Future.delayed(const Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      });

    } else {
      final errorData = jsonDecode(response.body);
      final errorMessage = (errorData is Map && errorData.containsKey('message'))
          ? errorData['message']
          : "Error en el registro";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  } catch (e) {
    if (!context.mounted) return; // Evita usar context si no está montado

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error de conexión: $e')),
    );
  }
}
}
