import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/presentation/worker/worker_notifications_screen.dart';
import 'package:test_app/presentation/worker/worker_profile_screen.dart';
import 'package:test_app/presentation/worker/worker_settings_screen.dart';

class WorkerPopupMenu extends StatelessWidget {
  const WorkerPopupMenu({Key? key}) : super(key: key);

  void _navigateToScreen(BuildContext context, Widget screen) {
    // Navega a la pantalla deseada usando Get
    Get.to(() => screen);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (int value) {
        switch (value) {
          case 1:
            _navigateToScreen(context, WorkerProfileScreen());
            break;
          case 2:
            _navigateToScreen(context, const WorkerSettingsScreen());
            break;
          case 3:
            _navigateToScreen(context, const WorkerNotificationsScreen());
            break;
          default:
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 1,
          child: Text('Perfil Trabajador'),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Text('Configuración'),
        ),
        PopupMenuItem<int>(
          value: 3,
          child: Text('Notificaciones'),
        ),
      ],
      child: const Icon(Icons.menu, color: Colors.black),
    );
  }
}
