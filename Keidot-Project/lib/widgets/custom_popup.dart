import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/client_profile_screen.dart';
import 'package:test_app/presentation/screens/config_screen.dart';
import 'package:test_app/presentation/screens/home_screen.dart';
import 'package:test_app/presentation/screens/request_screen.dart';
import 'package:test_app/presentation/screens/requests_screen.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 20,
      surfaceTintColor: defaultWhite,
      icon: const Icon(Icons.menu),

      // Aplicar el color a todos los textos
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onTap: () => _navigateToScreen(context, ClientProfileScreen()),
            child: _buildMenuText("Mi perfil"),
          ),
          PopupMenuItem(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onTap: () => _navigateToScreen(context, const ConfigScreen()),
            child: _buildMenuText("Configuración"),
          ),
          PopupMenuItem(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onTap: () => _navigateToScreen(context, const RequestsScreen()),
            child: _buildMenuText("Solicitudes"),
          ),
          PopupMenuItem(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onTap: () => _navigateToScreen(context, const HomeScreen()),
            child: _buildMenuText("Acerca de"),
          ),
        ];
      },
    );
  }

  // Método para aplicar el mismo estilo a todos los textos
  Widget _buildMenuText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: darkGreen, // Cambia el color aquí
        fontWeight: FontWeight.w500,
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Future.delayed(Duration.zero, () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    });
  }
}
