import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_appbar.dart';
import 'package:test_app/widgets/custom_input.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Registrarse',
        toolbarHeight: 90,
        backgroundColor: const Color.fromARGB(255, 189, 189, 189),
        titleColor: darkGreen,
        iconColor: darkGreen,
        onBackPressed: () {
          Navigator.pop(context); // Acción al presionar el botón de retroceso
        },
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            CustomInput(
              labelText: 'Usuario',
              prefixIcon: Icons.people,
              controller: emailController,
            ),
            const SizedBox(height: 16),
            CustomInput(
              labelText: 'Correo electrónico',
              prefixIcon: Icons.email,
              controller: emailController,
            ),
            const SizedBox(height: 16),
            CustomInput(
              labelText: 'Teléfono',
              prefixIcon: Icons.phone,
              controller: emailController,
            ),
            const SizedBox(height: 16),
          ],
        ),
      )),
    );
  }
}
