import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_app/presentation/screens/home_page.dart';

class AuthService {
  final String baseUrl = 'https://keidot.azurewebsites.net/api/Login/login';
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> login(BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await storage.write(key: 'token', value: data['token']);
        await storage.write(key: 'userId', value: data['id']); // Guarda el ID del usuario
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales incorrectas')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al iniciar sesión')),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'userId'); // Elimina el ID del usuario al cerrar sesión
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<String?> getUserId() async {
    return await storage.read(key: 'userId'); // Recupera el ID del usuario
  }
}