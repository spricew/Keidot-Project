import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class WorkerNotificationsScreen extends StatefulWidget {
  const WorkerNotificationsScreen({super.key});

  @override
  _WorkerNotificationsScreenState createState() => _WorkerNotificationsScreenState();
}

class _WorkerNotificationsScreenState extends State<WorkerNotificationsScreen> {
  List<Map<String, dynamic>> notifications = [
    {
      'date': '30 de Jul. 2025',
      'message': 'Has sido seleccionado para el trabajo de "Jardinería" en la dirección Av. Siempre Viva 123.',
      'isRead': false, // No leído
    },
    {
      'date': '28 de Jul. 2025',
      'message': 'Tu solicitud para el trabajo de "Jardinería" ha sido rechazada.',
      'isRead': true, // Leído
    },
    {
      'date': '22 de Jul. 2025',
      'message': 'Has recibido una nueva oferta para el trabajo de "Limpieza de jardín" con un pago de \$150.',
      'isRead': false, // No leído
    },
    {
      'date': '18 de Jul. 2025',
      'message': 'El cliente ha cancelado el trabajo de "Decoración de jardín" al que habías aplicado.',
      'isRead': true, // Leído
    },
    {
      'date': '15 de Jul. 2025',
      'message': 'Has completado con éxito el trabajo de "Limpieza de jardín". ¡Gracias por tu esfuerzo!',
      'isRead': false, // No leído
    },
  ];

  // Función para marcar una notificación como leída
  void markAsRead(int index) {
    setState(() {
      notifications[index]['isRead'] = true;
    });
  }

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
          //  cierra la pantalla actual 
          Navigator.of(context).pop();
        },
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: Icon(
              Icons.circle,
              color: notification['isRead'] ? Colors.grey : Colors.green, // Icono verde si no está leído, gris si está leído
              size: 12,
            ),
            title: Text(
              notification['message'],
              style: TextStyle(
                fontWeight: notification['isRead'] ? FontWeight.normal : FontWeight.bold, // Texto en negrita si no está leído
                color: notification['isRead'] ? Colors.grey : Colors.black, // Texto gris si está leído, negro si no
              ),
            ),
            subtitle: Text(
              notification['date'],
              style: TextStyle(
                color: notification['isRead'] ? Colors.grey : Colors.black54, // Fecha gris si está leído
              ),
            ),
            onTap: () {
              markAsRead(index); // Marcar como leído al tocar
            },
          );
        },
      ),
    );
  }
}