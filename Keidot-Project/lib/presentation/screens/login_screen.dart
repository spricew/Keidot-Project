import 'package:flutter/material.dart';
import 'package:test_app/Services/login_request/auth_serviceController.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/register_screen.dart';
import 'package:test_app/widgets/custom_input.dart';
import 'package:test_app/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool obscurePassword = true; // Controla la visibilidad de la contraseña

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                              builder: (context) => const RegisterScreen()),
                        );
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
                    CustomInput(
                      labelText: 'Correo electrónico',
                      prefixIcon: Icons.email,
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    CustomInput(
                      labelText: 'Contraseña',
                      prefixIcon: Icons.lock,
                      obscureText: obscurePassword,
                      suffixIcon:
                          obscurePassword ? Icons.visibility_off : Icons.visibility,
                      controller: passwordController,
                      onSuffixIconTap: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('¿Olvidaste tu contraseña?'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomButton(
                      text: 'Iniciar sesión',
                      onPressed: () async {
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();

                        if (email.isNotEmpty && password.isNotEmpty) {
                          await authService.login(context, email, password);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Por favor, completa todos los campos'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
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
                            onPressed: () {},
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
                            onPressed: () {},
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
