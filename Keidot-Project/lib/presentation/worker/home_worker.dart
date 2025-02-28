import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/worker/search_worker.dart';
import 'package:test_app/presentation/worker/worker_messages.dart';
import 'package:test_app/widgets/worker_popup_menu.dart';
import 'package:test_app/presentation/worker/service_requests_screen.dart'; // Importa la nueva pantalla

class HomeWorker extends StatefulWidget {
  const HomeWorker({super.key});

  @override
  _HomeWorkerState createState() => _HomeWorkerState();
}

class _HomeWorkerState extends State<HomeWorker> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  Timer? _carouselTimer;

  // Lista de nombres de servicios destacados
  final List<String> serviceNames = [
    "Venta de plantas y semillas",
    "Corte de césped",
    "Limpieza de jardín",
    "Alquiler de herramientas de jardinería"
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients && _pageController.page != null) {
        int nextPage = ((_pageController.page?.round() ?? 0) + 1) % 4;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentIndex = nextPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _carouselTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: const WorkerPopupMenu(), // Se usa el menú de trabajador
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Keidot (Trabajador)',
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
            _buildServicesGrid(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
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
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
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
      ),
    );
  }

  Widget _buildImageCarousel() {
    return SizedBox(
      height: 230,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 4,
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
              image: const DecorationImage(
                image: NetworkImage('https://via.placeholder.com/800x400'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServicesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.84,
      ),
      itemCount: serviceNames.length,
      itemBuilder: (context, index) {
        return _gridItem(index);
      },
    );
  }

  Widget _gridItem(int index) {
    return GestureDetector(
      onTap: () {
        // Redirige a la nueva pantalla pasándole el nombre del servicio seleccionado
        Get.to(() => ServiceRequestsScreen(serviceName: serviceNames[index]));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: NetworkImage('https://via.placeholder.com/150'),
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
            serviceNames[index],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
