import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/login_screen.dart';
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

  File? _selectedFile; // Variable para almacenar el archivo seleccionado
  String? _fileName; // Nombre del archivo

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Define los tipos de archivo permitidos
      allowedExtensions: ['jpg', 'png', 'pdf'], // Extensiones permitidas
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!); // Ruta del archivo
        _fileName = result.files.single.name; // Nombre del archivo
      });
    } else {
      // El usuario canceló la selección
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se seleccionó ningún archivo.')),
      );
    }
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
          Navigator.pop(context); // Acción al presionar el botón de retroceso
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        height: double.infinity,
        color: defaultWhite,
        child: SingleChildScrollView(
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
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment
                    .centerLeft, // Alinea específicamente este texto a la izquierda
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
