import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_app/presentation/screens/home_page.dart';

class AuthService {
  final String baseUrl = 'https://keidot.azurewebsites.net/api/Login/login';
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await storage.write(key: 'name', value: data['name']);//Guarda el 
        await storage.write(key: 'token', value: data['token']);//Guarda el
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
    await storage.delete(key: 'token');//Elimina mi token cuando cierro sesion
    await storage.delete(key: 'userId'); // Elimina el ID del usuario al cerrar sesión
    await storage.delete(key: 'name'); //Matamos al name
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token'); //Recupera el token
  }

  Future<String?> getUserId() async {
    return await storage.read(key: 'userId'); // Recupera el ID del usuario
  }
    Future<String?> getUserName() async {
    return await storage.read(key: 'name'); // Recupera el name del usuario
  }
}


