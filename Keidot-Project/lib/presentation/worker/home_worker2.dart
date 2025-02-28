import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/presentation/screens/messages_screen.dart';
import 'package:test_app/presentation/screens/notifications_screen.dart';
import 'package:test_app/presentation/screens/request_screen1.dart';
import 'package:test_app/presentation/screens/search_screen.dart';
import 'package:test_app/presentation/screens/home_screen.dart';
import 'package:test_app/presentation/worker/search_worker.dart';
import 'package:test_app/presentation/worker/worker_messages.dart';

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
      const HomeScreen(),
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
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });

        // Manejar navegación con Get.offAll() en ciertos casos
        switch (index) {
          case 1:
            Get.offAll(() => const SearchWorkerScreen());
            break;
          case 2:
            Get.offAll(() => const WorkerMessagesScreen());
            break;
        }
      },
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Mensajes',
        ),
      ],
    ),
  );
}
}
