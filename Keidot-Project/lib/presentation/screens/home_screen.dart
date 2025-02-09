import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_app/Services/models/service_model.dart';
import 'package:test_app/Services/services_request/service_controller.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/config_screen.dart';
import 'package:test_app/presentation/screens/client_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Service> services = [];
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  Future<void> fetchServices() async {
    try {
      List<Service> apiServices = await ApiService.fetchServices();
      setState(() {
        services = apiServices;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ClientProfileScreen()),
                  );
                },
                child: const InkWell(
                  child: Text("Mi perfil"),
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConfigScreen()),
                  );
                },
                child: const InkWell(
                  child: Text("Configuración"),
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConfigScreen()),
                  );
                },
                child: const InkWell(
                  child: Text("Acerca de"),
                ),
              ),
            ];
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Keidot',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.8,
              color: greenHigh,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageCarousel(),
            const SizedBox(height: 28),
            const Text(
              'Servicios destacados',
              style: TextStyle(
                color: darkGreen,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.84,
              ),
              itemCount: services.length > 4 ? 4 : services.length, //Limitar a mostras solo 4 Servicios que son los mas destacados
              itemBuilder: (context, index) {
                return _gridItem(services[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// **Carrusel de imágenes**
  Widget _buildImageCarousel() {
    if (services.isEmpty) {
      return Container(
        width: double.infinity,
        height: 230,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Text(
            'Cargando imágenes...',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 230,
          child: PageView.builder(
            controller: _pageController,
            itemCount: services.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(services[index].urlImage),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            services.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.green : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _gridItem(Service service) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(service.urlImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Text(
          service.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
