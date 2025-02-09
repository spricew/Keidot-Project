import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/presentation/screens/login_screen.dart';
import 'dart:convert';
import '../models/user_model.dart';

class RegisterService {
  final String baseUrl = 'https://keidot.azurewebsites.net/api/RegisterUsers';

  Future<void> register(BuildContext context, UserModel user) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json',
        'Accept': 'application/json', },
        body: jsonEncode(user.toJson()),
      );

      print("Código de estado: ${response.statusCode}");
      print("Respuesta del servidor: ${response.body}"); 

      if (response.statusCode == 201) {
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
        final errorMessage = jsonDecode(response.body)['message'] ?? "Error en el registro";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión: $e')),
      );
    }
  }
}
