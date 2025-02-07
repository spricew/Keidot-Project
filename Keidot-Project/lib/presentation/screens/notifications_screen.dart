import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';

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
      'message':
          'Kevin Montero ha solicitado el trabajo de "Jardinerita" que has pedido con anterioridad.',
      'isRead': false,
    },
    {
      'date': '28 de Jul. 2024',
      'message':
          'Rommel Canepa ha solicitado el trabajo de "Jardinerita" que has pedido con anterioridad.',
      'isRead': true,
    },
    // Más notificaciones...
  ];

  void markAsRead(int index) {
    setState(() {
      notifications[index]['isRead'] = true;
    });
  }

  void deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notificaciones',
          style: TextStyle(fontSize: 24, color: darkGreen),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: darkGreen),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navegar de vuelta
          },
        ),
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                'No tienes notificaciones',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Dismissible(
                  key: Key(notification['message']),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    deleteNotification(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Notificación eliminada')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.circle,
                      color:
                          notification['isRead'] ? Colors.grey : Colors.green,
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
                  ),
                );
              },
            ),
    );
  }
}
