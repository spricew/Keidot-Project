import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/messages_screen.dart';
import 'package:test_app/presentation/screens/notifications_screen.dart';
import 'package:test_app/presentation/screens/request_screen1.dart';
import 'package:test_app/presentation/screens/search_screen.dart';
import 'package:test_app/presentation/screens/home_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  late List<Widget> _screens; // Definimos la lista sin inicializarla aquí

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      SearchScreen(onTabSelected: _onItemTapped), // Ahora sí podemos usarla
      const DetallesServicioPage(),
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
        onTap: _onItemTapped,
        selectedItemColor: darkGreen,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: 'Solicitar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notificaciones'),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: 'Mensajes'),
        ],
      ),
    );
  }
}
