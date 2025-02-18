import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:test_app/Services/models/user_model.dart';
import 'package:test_app/Services/register_and_update_request/register_service_controller.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_appbar.dart';
import 'package:test_app/widgets/custom_button.dart';
import 'package:test_app/widgets/custom_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final RegisterService _registerService = RegisterService();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  File? _selectedFile;
  String? _fileName;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se seleccionó ningún archivo.')),
      );
    }
  }

  void _register() async {
    final user = UserModel(
      email: emailController.text,
      username: usernameController.text,
      phone: int.tryParse(phoneController.text) ?? 0,
      password: passwordController.text,
    );

    await _registerService.register(context, user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'Registrarse',
        titleFontSize: 28,
        toolbarHeight: 125,
        backgroundColor: Colors.white,
        titleColor: darkGreen,
        iconColor: darkGreen,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        height: double.infinity,
        color: defaultWhite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomInput(
                labelText: 'Nombre de usuario',
                prefixIcon: Icons.people,
                controller: usernameController,
              ),
              const SizedBox(height: 18),
              CustomInput(
                labelText: 'Correo electrónico',
                prefixIcon: Icons.email,
                controller: emailController,
              ),
              const SizedBox(height: 18),
              CustomInput(
                labelText: 'Teléfono',
                prefixIcon: Icons.phone,
                controller: phoneController,
              ),
              const SizedBox(height: 18),
              CustomInput(
                labelText: 'Contraseña',
                prefixIcon: Icons.password,
                controller: passwordController,
                obscureText: obscurePassword,
                suffixIcon:
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                onSuffixIconTap: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
              const SizedBox(height: 18),
              CustomInput(
                labelText: 'Repetir contraseña',
                prefixIcon: Icons.lock,
                obscureText: obscureConfirmPassword,
                suffixIcon: obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                onSuffixIconTap: () {
                  setState(() {
                    obscureConfirmPassword = !obscureConfirmPassword;
                  });
                },
              ),
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Identificación oficial:',
                  style: TextStyle(
                      color: darkGreen, fontSize: 18, fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.upload_file),
                label: const Text('Seleccionar archivo'),
              ),
              const SizedBox(height: 12),
              if (_selectedFile != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Archivo seleccionado:',
                      style: TextStyle(
                        color: darkGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Nombre: $_fileName'),
                    Text('Ruta: ${_selectedFile!.path}'),
                  ],
                )
              else
                const Text('No se ha seleccionado ningún archivo.'),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Registrarse',
                onPressed: _register,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
