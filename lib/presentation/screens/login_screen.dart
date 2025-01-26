import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/register_screen.dart';
import 'package:test_app/widgets/custom_input.dart';
import 'package:test_app/widgets/custom_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Declarar los controladores para los campos de texto
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            'assets/images/banner.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
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
                        letterSpacing: -1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                        // Lógica para redirigir a Crear cuenta
                      },
                      child: const Text(
                        'Crear cuenta',
                        style: TextStyle(
                          fontSize: 20,
                          color: greenHigh,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          letterSpacing: -0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Campo de correo electrónico reutilizable
                    CustomInput(
                      labelText: 'Correo electrónico',
                      prefixIcon: Icons.email,
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    // Campo de contraseña reutilizable
                    CustomInput(
                      labelText: 'Contraseña',
                      prefixIcon: Icons.lock,
                      obscureText: true,
                      suffixIcon: Icons.visibility_off,
                      controller: passwordController,
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
                    const SizedBox(height: 8),
                    CustomButton(
                      text: 'Iniciar sesión',
                      onPressed: () {
                        // Lógica para iniciar sesión

                        // ignore: avoid_print
                        print('Email: ${emailController.text}');
                        // ignore: avoid_print
                        print('Contraseña: ${passwordController.text}');
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            'O inicia sesión con',
                            style: TextStyle(color: darkGreen),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Lógica para iniciar sesión con Google
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: Colors.grey),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            icon: const Icon(Icons.account_circle),
                            label: const Text('Google'),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Lógica para iniciar sesión con Facebook
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              side: const BorderSide(color: Colors.grey),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            icon: const Icon(Icons.facebook),
                            label: const Text('Facebook'),
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
