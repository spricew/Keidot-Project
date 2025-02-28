import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:test_app/Services/models/user_model.dart';
import 'package:test_app/Services/client_request/register_and_update_request/register_service_controller.dart';
import 'package:test_app/Services/client_request/upload_image/file_converter.dart';
import 'package:test_app/Services/client_request/upload_image/file_uploader.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/login_screen.dart';
import 'package:test_app/widgets/custom_appbar.dart';
import 'package:test_app/widgets/custom_button.dart';
import 'package:test_app/widgets/custom_input.dart';
import 'package:flutter/services.dart';

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
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RegisterService _registerService = RegisterService();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  // Mapa para guardar los errores de validación
  Map<String, String> _errors = {};

  File? _selectedFile;
  String? _fileName;
  String? _imageUrl;
  bool isUploading = false; // 🔹 Estado para controlar la carga
  bool _isImageUploaded = false;
  String? usernameError;
  String? emailError;
  String? phoneError;
  String? passwordError;
  String? confirmPasswordError;

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
    print("URL antes del registro: $_imageUrl"); // DEBUG

    // Limpiar errores previos
    setState(() {
      usernameError = null;
      emailError = null;
      phoneError = null;
      passwordError = null;
      confirmPasswordError = null;
    });

    // Validar si la imagen está presente
    if (_imageUrl == null || _imageUrl!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Debes subir una imagen antes de registrarte."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Crear objeto del usuario
    final user = UserModel(
      email: emailController.text,
      username: usernameController.text,
      phone: int.tryParse(phoneController.text) ?? 0,
      password: passwordController.text,
      urlImage: _imageUrl!,
    );

    // Consumir el servicio de registro y obtener posibles errores
    final Map<String, dynamic>? errors =
        await _registerService.register(context, user);

    if (errors != null) {
      setState(() {
        usernameError = errors["Username"]?.first;
        emailError = errors["Email"]?.first;
        phoneError = errors["Phone"]?.first;
        passwordError = errors["Password"]?.first;
      });

      // Mostrar un mensaje si hay un error general
      if (errors.containsKey("general")) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errors["general"]?.first ?? "Error en el registro"),
            backgroundColor: Colors.red,
          ),
        );
      }
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
                errorText: usernameError,
                onChanged: (value) {
                  setState(() {
                    usernameError = value.length < 5
                        ? 'Debe tener al menos 3 caracteres'
                        : null;
                  });
                },
              ),
              const SizedBox(height: 18),
              CustomInput(
                labelText: 'Correo electrónico',
                prefixIcon: Icons.email,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                errorText: emailError,
                onChanged: (value) {
                  setState(() {
                    emailError = _validateEmail(value);
                  });
                },
              ),
              const SizedBox(height: 18),
              CustomInput(
                labelText: 'Teléfono',
                prefixIcon: Icons.phone,
                controller: phoneController,
                keyboardType: TextInputType.number,
                errorText: phoneError,
                onChanged: (value) {
                  setState(() {
                    if (value.length != 10 || int.tryParse(value) == null) {
                      phoneError = 'Ingrese un número de 10 dígitos';
                    } else {
                      phoneError = null;
                    }
                  });
                },
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
                errorText: passwordError,
                onChanged: (value) {
                  setState(() {
                    passwordError = value.length < 6
                        ? 'Debe tener al menos 6 caracteres'
                        : null;
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
                errorText: confirmPasswordError,
                onChanged: (value) {
                  setState(() {
                    confirmPasswordError = value != passwordController.text
                        ? 'Las contraseñas no coinciden'
                        : null;
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
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: isUploading
                    ? null
                    : () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'jpeg', 'png'],
                        );

                        if (result != null) {
                          setState(() {
                            isUploading = true;
                            _isImageUploaded =
                                false; // 🔹 Bloquea el botón hasta que la imagen se suba
                          });

                          String filePath = result.files.single.path!;
                          String fileName = result.files.single.name;
                          File file = File(filePath);

                          setState(() {
                            _selectedFile = file;
                            _fileName = fileName;
                          });

                          // Convertir archivo a Base64
                          String base64Image =
                              await FileConverter.convertToBase64(file);

                          // Subir imagen y obtener URL
                          String? imageUrl = await FileUploader.uploadImage(
                              base64Image, fileName);

                          setState(() {
                            isUploading = false;
                            if (imageUrl != null && imageUrl.isNotEmpty) {
                              _imageUrl = imageUrl;
                              _isImageUploaded =
                                  true; // 🔹 Habilita el botón al recibir la URL
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Error al subir la imagen.')),
                              );
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('No se seleccionó ningún archivo.')),
                          );
                        }
                      },
                icon: const Icon(Icons.upload_file),
                label: isUploading
                    ? const CircularProgressIndicator()
                    : const Text('Seleccionar archivo'),
              ),
              const SizedBox(height: 16),
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
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    const Text(
                      '¿Ya tienes cuenta?',
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text('Inicia sesión'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para validar el correo
  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Ingrese su correo electrónico';
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Ingrese un correo válido';
    }
    return null;
  }

  bool _isFormValid() {
    // Validar que el email sea válido
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      return false;
    }

    // Validar que el nombre de usuario no esté vacío
    if (usernameController.text.isEmpty) {
      return false;
    }

    // Validar que el teléfono tenga un formato válido
    if (phoneController.text.isEmpty ||
        int.tryParse(phoneController.text) == null) {
      return false;
    }

    // Validar que la contraseña tenga al menos 6 caracteres
    if (passwordController.text.length < 6) {
      return false;
    }

    // Validar que la confirmación de la contraseña coincida
    // Validar que la confirmación de la contraseña coincida
    if (confirmPasswordController.text != passwordController.text) {
      return false;
    }

    // Si todas las validaciones pasan, el formulario es válido
    return true;
  }
}
