import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_app/Services/models/service_model.dart';
import 'package:test_app/Services/services_request/service_controller.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_popup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Service> services = [];
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  Timer? _carouselTimer;

  @override
  void initState() {
    super.initState();
    fetchServices();
    _startAutoSlide();
  }

  Future<void> fetchServices() async {
    try {
      List<Service> apiServices = await ApiService.fetchServices();
      setState(() {
        services = apiServices;
      });
    } catch (e) {
      //ignore: avoid_print
      print("Error: $e");
    }
  }

  /// **Inicia el auto-slide del carrusel**
  void _startAutoSlide() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients && services.isNotEmpty) {
        int nextPage = (_currentIndex + 1) % services.length;
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
        leading: const CustomPopupMenu(),
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
              itemCount: services.length > 4 ? 4 : services.length,
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
                color: _currentIndex == index ? greenHigh : Colors.grey,
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
            colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
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
