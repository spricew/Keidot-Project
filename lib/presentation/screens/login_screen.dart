import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none, // Permite que los widgets salgan del Stack
        children: [
          Image.asset(
            'assets/images/banner.png',
            width: double.infinity,
            height: 380,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 300, // Ajusta para superponer la tarjeta
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: defaultWhite, // Cambia a blanco cuando lo necesites
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: darkGreen,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Lógica para redirigir a Crear cuenta
                      },
                      child: const Text(
                        'Crear cuenta',
                        style: TextStyle(
                          fontSize: 20,
                          color: greenHigh,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        labelStyle: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 10), // Agrega espacio al ícono
                          child: Icon(Icons.email,
                              size: 20), // Ajusta el tamaño del ícono
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Bordes redondeados
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, // Padding interno del texto
                          horizontal: 10, // Padding horizontal del texto
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.visibility_off),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Lógica para "¿Olvidaste tu contraseña?"
                        },
                        child: const Text('¿Olvidaste tu contraseña?'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para iniciar sesión
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: darkGreen,
                          minimumSize: const Size(double.infinity, 50),
                          textStyle: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      child: const Text(
                        'Iniciar sesión',
                        style: TextStyle(
                            color: defaultWhite,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          const Text('O inicia sesión con'),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Lógica para iniciar sesión con Google
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  side: const BorderSide(color: Colors.grey),
                                  minimumSize: const Size(150, 50),
                                ),
                                icon: const Icon(Icons.account_circle),
                                label: const Text('Google'),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Lógica para iniciar sesión con Facebook
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blue,
                                  side: const BorderSide(color: Colors.grey),
                                  minimumSize: const Size(150, 50),
                                ),
                                icon: const Icon(Icons.facebook),
                                label: const Text('Facebook'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
