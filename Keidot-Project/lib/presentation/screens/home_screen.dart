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
  int currentIndex = 0;
  Timer? _timer;

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
      if (services.isNotEmpty) {
        startImageRotation();
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void startImageRotation() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % services.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
                child: InkWell(
                  child: const Text("Mi perfil"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClientProfileScreen()),
                    );
                  },
                ),
              ),
              PopupMenuItem(
                child: InkWell(
                  child: const Text("Configuración"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfigScreen()),
                    );
                  },
                ),
              ),
              PopupMenuItem(
                child: InkWell(
                  child: const Text("Acerca de"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfigScreen()),
                    );
                  },
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
            Container(
              width: double.infinity,
              height: 230,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
                image: services.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(services[currentIndex].urlImage),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: services.isEmpty
                  ? const Center(
                      child: Text(
                        'Cargando imágenes...',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : null,
            ),
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
              itemCount: services.length,
              itemBuilder: (context, index) {
                return _gridItem(services[index]);
              },
            ),
          ],
        ),
      ),
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
