import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/login_screen.dart';
import 'package:test_app/widgets/custom_appbar.dart';
import 'package:test_app/widgets/custom_button.dart';
import 'package:test_app/widgets/custom_input.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'Registrarse',
        toolbarHeight: 125,
        backgroundColor: Colors.white,
        titleColor: darkGreen,
        iconColor: darkGreen,
        onBackPressed: () {
          Navigator.pop(context); // Acción al presionar el botón de retroceso
        },
      ),
      body: Container(
        color: Colors.white,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          child: Column(
            children: [
              const CustomInput(
                labelText: 'Usuario',
                prefixIcon: Icons.people,
              ),
              const SizedBox(height: 18),
              CustomInput(
                labelText: 'Correo electrónico',
                prefixIcon: Icons.email,
                controller: emailController,
              ),
              const SizedBox(height: 18),
              const CustomInput(
                labelText: 'Teléfono',
                prefixIcon: Icons.phone,
              ),
              const SizedBox(height: 18),
              CustomInput(
                labelText: 'Contraseña',
                prefixIcon: Icons.password,
                controller: passwordController,
                obscureText: true,
                suffixIcon: Icons.visibility_off,
              ),
              const SizedBox(height: 18),
              CustomInput(
                labelText: 'Repetir contraseña',
                prefixIcon: Icons.lock,
                controller: passwordController,
                obscureText: true,
                suffixIcon: Icons.visibility_off,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Registrarse',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
