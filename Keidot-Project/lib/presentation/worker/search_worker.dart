import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/request_screen1.dart'; // Manteniendo el RequestScreen1 como ejemplo
import 'package:test_app/widgets/custom_appbar.dart';

class SearchWorkerScreen extends StatefulWidget {
  const SearchWorkerScreen({super.key});

  @override
  _SearchWorkerScreenState createState() => _SearchWorkerScreenState();
}

class _SearchWorkerScreenState extends State<SearchWorkerScreen> {
  final TextEditingController searchController = TextEditingController();

  // Lista de servicios estáticos para la maqueta
  List<Map<String, dynamic>> services = [
    {'service_id': '1', 'title': 'Venta de plantas y semillas'},
    {'service_id': '2', 'title': 'Corte de césped'},
    {'service_id': '3', 'title': 'Limpieza de jardín'},
    {'service_id': '4', 'title': 'Alquiler de herramientas de jardineria'},
  ];
  List<Map<String, dynamic>> filteredServices = [];

  @override
  void initState() {
    super.initState();
    // Inicia la lista filtrada con todos los servicios
    filteredServices = services;

    // Escuchar cambios en el campo de búsqueda y actualizar la lista en tiempo real
    searchController.addListener(() {
      filterServices();
    });
  }

  void filterServices() {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      setState(() {
        filteredServices = services; // Si la búsqueda está vacía, muestra todos los servicios
      });
    } else {
      setState(() {
        filteredServices = services
            .where((service) => service['title']
                .toLowerCase()
                .contains(query)) // Filtra por nombre de servicio
            .toList();
      });
    }
  }

  void selectService(String serviceId, String serviceName) {
    // Simula la selección del servicio y navega a la siguiente pantalla
    Get.to(() => const RequestScreen1());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Buscar Servicios',
        titleFontSize: 28,
        toolbarHeight: 85,
        backgroundColor: Colors.white,
        titleColor: darkGreen,
        iconColor: darkGreen,
        onBackPressed: () {
          Get.back(); // Navegar hacia atrás
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de búsqueda
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Buscar servicio...",
                  prefixIcon: const Icon(Icons.search, color: darkGreen),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Lista de servicios
            Expanded(
              child: filteredServices.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredServices.length,
                      itemBuilder: (context, index) {
                        final service = filteredServices[index];
                        final serviceId = service['service_id'].toString();
                        final serviceName = service['title'] ?? "Sin título";
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () => selectService(serviceId, serviceName),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Icon(
                                    _getServiceIcon(serviceName),
                                    size: 30,
                                    color: darkGreen,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      serviceName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: darkGreen,
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios,
                                      size: 20, color: darkGreen),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "No se encontraron servicios",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para obtener un ícono relacionado con el servicio
  IconData _getServiceIcon(String serviceName) {
    if (serviceName.toLowerCase().contains('plom')) {
      return Icons.plumbing;
    } else if (serviceName.toLowerCase().contains('electric')) {
      return Icons.electrical_services;
    } else if (serviceName.toLowerCase().contains('limpieza')) {
      return Icons.cleaning_services;
    } else if (serviceName.toLowerCase().contains('jardín')) {
      return Icons.nature;
    } else {
      return Icons.build; // Ícono por defecto
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
