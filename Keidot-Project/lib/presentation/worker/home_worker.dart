import 'package:flutter/material.dart';
import 'package:test_app/presentation/screens/messages_screen.dart';
import 'package:test_app/presentation/screens/notifications_screen.dart';
import 'package:test_app/presentation/screens/request_screen1.dart';
import 'package:test_app/presentation/screens/search_screen.dart';
import 'package:test_app/presentation/worker/worker_job_requests_screen.dart';

class HomepageWorker extends StatefulWidget {
  const HomepageWorker({super.key});

  @override
  State<HomepageWorker> createState() => _HomepageState();
}

class _HomepageState extends State<HomepageWorker> {
  int _selectedIndex = 0;

  late List<Widget> _screens; // Definimos la lista sin inicializarla aquí

  @override
  void initState() {
    super.initState();
    _screens = [
      const WorkerJobRequestsScreen(),
      SearchScreen(onTabSelected: _onItemTapped), // Ahora sí podemos usarla
      const RequestScreen1(),
      const NotificationsScreen(),
      const MessagesScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
    );
  }
}
