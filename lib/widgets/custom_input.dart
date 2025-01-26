import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String labelText; // Texto de la etiqueta
  final bool obscureText; // Define si el texto está oculto
  final IconData prefixIcon; // Ícono de la izquierda
  final IconData? suffixIcon; // Ícono de la derecha opcional
  final TextInputType keyboardType; // Tipo de teclado
  final TextEditingController? controller; // Controlador opcional

  const CustomInput({
    super.key,
    required this.labelText,
    this.obscureText = false,
    required this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontFamily: 'Urbanist',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: Icon(prefixIcon, size: 22),
        ),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon)
            : null, // Muestra el ícono solo si se proporciona
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
      ),
    );
  }
}
