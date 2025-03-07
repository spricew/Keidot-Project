import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/change_name.dart';
import 'package:test_app/presentation/screens/messages_screen.dart';
import 'package:test_app/presentation/screens/new_worker.dart';
import 'package:test_app/presentation/screens/notifications_screen.dart';
import 'package:test_app/presentation/screens/request_screen1.dart';
import 'package:test_app/presentation/screens/search_screen.dart';
import 'package:test_app/presentation/worker/worker_assignments_screen.dart';
import 'package:test_app/presentation/worker/worker_job_requests_screen.dart';
import 'package:test_app/presentation/worker/worker_messages.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class HomeWorker extends StatelessWidget {
  const HomeWorker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Página del trabajador'),),
      body: _ViewHomeWorker(),
    );
  }
}

class _ViewHomeWorker extends StatelessWidget {
  final List<Map<String, dynamic>> options = [
    {
      'title': 'Trabajos disponibles',
      'icon': Icons.event_available,
      'screen': const WorkerJobRequestsScreen(), // Pantalla para cambiar nombre
    },
    {
      'title': 'Trabajos pendientes',
      'icon': Icons.timelapse,
      'screen': WorkerAssignmentsScreen(), // Pantalla para cambiar contraseña
    },
    {
      'title': 'Mensajes',
      'icon': Icons.send,
      'screen':
          const WorkerMessagesScreen(), // Pantalla para convertirse en trabajador
    },
    {
      'title': 'Soporte',
      'icon': Icons.help,
      'screen': const WorkerMessagesScreen(), // Pantalla para soporte
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return _OptionCard(
                    title: options[index]['title'],
                    icon: options[index]['icon'],
                    screen: options[index]['screen'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget screen;

  const _OptionCard({
    required this.title,
    required this.icon,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        // Navegar a la pantalla correspondiente
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: colors.outline, width: 0.3),
              color: colors.onPrimary,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: size.height * 0.08,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 22, color: Colors.grey),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: TextStyle(
                        color: colors.onPrimaryContainer,
                        fontSize: size.height * 0.019,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 20, color: Colors.grey),
              ],
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
