import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String labelText; // Texto de la etiqueta
  final bool obscureText; // Define si el texto está oculto
  final IconData prefixIcon; // Ícono de la izquierda
  final IconData? suffixIcon; // Ícono de la derecha opcional
  final TextInputType keyboardType; // Tipo de teclado
  final TextEditingController? controller; // Controlador opcional
  final VoidCallback? onSuffixIconTap; // Callback opcional para el tap en el ícono de la derecha

  const CustomInput({
    super.key,
    required this.labelText,
    this.obscureText = false,
    required this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onSuffixIconTap,
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
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: onSuffixIconTap, // Ahora reacciona al tap
                ),
              )
            : null,
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
