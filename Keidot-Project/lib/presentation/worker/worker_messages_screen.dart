import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class WorkerMessagesScreen extends StatelessWidget {
  const WorkerMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Aquí puedes controlar lo que pasa cuando se presiona el botón de regresar
        Navigator.pop(context); // Regresa a la pantalla anterior
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Mensajes',
          titleFontSize: 28,
          toolbarHeight: 85,
          backgroundColor: Colors.white,
          titleColor: darkGreen,
          iconColor: darkGreen,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 35, color: darkGreen),
                ),
                title: Text(
                  'Contacto ${index + 1}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                subtitle: Text(
                  'Hola, ¿cómo estás?',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                trailing: Text(
                  '12:30 PM',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                onTap: () {
                  // Acción al tocar un chat
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
