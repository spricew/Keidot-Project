import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_appbar.dart';
import 'home_screen.dart'; // Importa HomeScreen

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Lista de notificaciones con estado mutable
  List<Map<String, dynamic>> notifications = [
    {
      'date': '30 de Jul. 2024',
      'message': 'Kevin Montero ha solicitado el trabajo de "Jardinerita" que has pedido con anterioridad.',
      'isRead': false, // No leído
    },
    {
      'date': '28 de Jul. 2024',
      'message': 'Rommel Canepa ha solicitado el trabajo de "Jardinerita" que has pedido con anterioridad.',
      'isRead': true, // Leído
    },
    {
      'date': '22 de Jul. 2024',
      'message': 'Rommel Canepa ha solicitado el trabajo de "Jardinerita" que has pedido con anterioridad.',
      'isRead': false, // No leído
    },
    {
      'date': '18 de Jul. 2024',
      'message': 'Rommel Canepa ha solicitado el trabajo de "Jardinerita" que has pedido con anterioridad.',
      'isRead': true, // Leído
    },
    {
      'date': '15 de Jul. 2024',
      'message': 'Rommel Canepa ha solicitado el trabajo de "Jardinerita" que has pedido con anterioridad.',
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
          // Redirigir a home_screen.dart usando GetX
          Get.offAll(() => const HomeScreen());
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
  }}