import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notificaciones',
        titleFontSize: 28,
        toolbarHeight: 85,
        backgroundColor: Colors.white,
        titleColor: darkGreen,
        iconColor: darkGreen,
        onBackPressed: () {
          // Regresar a la pantalla anterior
          Navigator.pop(context);
        },
      ),
      // Aquí puedes agregar el contenido de la pantalla de notificaciones
      body: const Center(
        child: Text('Contenido de Notificaciones'),
      ),
    );
  }
}
