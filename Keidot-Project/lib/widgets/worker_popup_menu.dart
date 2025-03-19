import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/presentation/worker/worker_notifications_screen.dart';
import 'package:test_app/presentation/worker/worker_profile_screen.dart';
import 'package:test_app/presentation/worker/worker_assignments_screen.dart';
import 'package:test_app/presentation/worker/worker_settings_screen.dart';

class WorkerPopupMenu extends StatelessWidget {
  const WorkerPopupMenu({super.key});

  void _navigateToScreen(Widget screen) {
    Get.to(() => screen);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (int value) {
        switch (value) {
          case 1:
            _navigateToScreen( const WorkerProfileScreen());
            break;
          case 2:
            _navigateToScreen(const WorkerSettingsScreen());
            break;
          case 3:
            _navigateToScreen(const WorkerNotificationsScreen());
            break;
          case 4:
            _navigateToScreen(const WorkerAssignmentsScreen());
            break;
          default:
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        const PopupMenuItem<int>(
          value: 1,
          child: Text('Perfil Trabajador'),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: Text('Configuración'),
        ),
        const PopupMenuItem<int>(
          value: 3,
          child: Text('Notificaciones'),
        ),
        const PopupMenuItem<int>(
          value: 4,
          child: Text('Trabajos Aceptados'),
        ),
      ],
      child: const Icon(Icons.menu, color: Colors.black),
    );
  }
}
