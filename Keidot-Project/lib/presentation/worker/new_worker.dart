import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewWorkerScreen extends StatelessWidget {
  const NewWorkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          'Convertirse en Trabajador',
          style: TextStyle(
            color: Color(0xFF3BA670),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),    
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: NewWorkerForm(),
      ),
    );
  }
}

class NewWorkerForm extends StatefulWidget {
  const NewWorkerForm({super.key});

  @override
  _NewWorkerFormState createState() => _NewWorkerFormState();
}

class _NewWorkerFormState extends State<NewWorkerForm> {
  final _formKey = GlobalKey<FormState>();
  
  String urlImagePerfil = '';
  String address = '';
  String city = '';
  int experienceYears = 0;
  String skills = '';
  String biography = '';

  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    String? Function(String?)? validator,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            label: 'URL de la imagen de perfil',
            onChanged: (value) => urlImagePerfil = value,
            validator: (value) => value == null || value.isEmpty ? 'Ingresa una URL válida' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Dirección',
            onChanged: (value) => address = value,
            validator: (value) => value == null || value.isEmpty ? 'Ingresa tu dirección' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Ciudad',
            onChanged: (value) => city = value,
            validator: (value) => value == null || value.isEmpty ? 'Ingresa tu ciudad' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Años de experiencia',
            keyboardType: TextInputType.number,
            onChanged: (value) => experienceYears = int.tryParse(value) ?? 0,
            validator: (value) => (value == null || int.tryParse(value) == null) ? 'Ingresa un número válido' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Biografía',
            maxLines: 5,
            onChanged: (value) => biography = value,
            validator: (value) => value == null || value.isEmpty ? 'Escribe una breve biografía' : null,
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Get.snackbar(
                    'Éxito',
                    'Formulario enviado correctamente',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                  print('Datos enviados');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF12372A),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Enviar',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
