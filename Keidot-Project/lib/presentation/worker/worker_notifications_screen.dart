import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/worker/home_worker2.dart';
import 'package:test_app/widgets/custom_appbar.dart';
// Asegúrate de que la ruta sea la correcta

class WorkerNotificationsScreen extends StatefulWidget {
  const WorkerNotificationsScreen({super.key});

  @override
  _WorkerNotificationsScreenState createState() =>
      _WorkerNotificationsScreenState();
}

class _WorkerNotificationsScreenState extends State<WorkerNotificationsScreen> {
  // Lista de notificaciones (dummy data)
  List<Map<String, dynamic>> notifications = [
    {
      'date': '30 de Jul. 2024',
      'message': 'Cliente X ha solicitado tu servicio de "Jardinería".',
      'isRead': false,
    },
    {
      'date': '28 de Jul. 2024',
      'message': 'Cliente Y ha calificado tu servicio.',
      'isRead': true,
    },
    {
      'date': '22 de Jul. 2024',
      'message': 'Cliente Z ha solicitado tu servicio.',
      'isRead': false,
    },
    {
      'date': '18 de Jul. 2024',
      'message': 'Cliente W ha dejado un comentario.',
      'isRead': true,
    },
    {
      'date': '15 de Jul. 2024',
      'message': 'Cliente V ha solicitado tu servicio.',
      'isRead': false,
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
          // Regresa a la Home de Trabajadores
          Get.offAll(() => const HomepageWorker());
        },
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: Icon(
              Icons.circle,
              color: notification['isRead'] ? Colors.grey : Colors.green,
              size: 12,
            ),
            title: Text(
              notification['message'],
              style: TextStyle(
                fontWeight: notification['isRead']
                    ? FontWeight.normal
                    : FontWeight.bold,
                color:
                    notification['isRead'] ? Colors.grey : Colors.black,
              ),
            ),
            subtitle: Text(
              notification['date'],
              style: TextStyle(
                color: notification['isRead']
                    ? Colors.grey
                    : Colors.black54,
              ),
            ),
            onTap: () {
              markAsRead(index);
            },
          );
        },
      ),
    );
  }
}
