import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/worker_request/assignments_publish/jobs_publish.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/request_screen1.dart';
// Importa HomeWorker
import 'package:test_app/presentation/worker/home_worker2.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class SearchWorkerScreen extends StatefulWidget {
  const SearchWorkerScreen({super.key});

  @override
  _SearchWorkerScreenState createState() => _SearchWorkerScreenState();
}

class _SearchWorkerScreenState extends State<SearchWorkerScreen> {
  final TextEditingController searchController = TextEditingController();
  final JobsPublishService _jobsPublishService = JobsPublishService();

  List filteredServices = [];

  void fetchAndSetServices() async {
    filteredServices = await _jobsPublishService.fetchAllJobs();
    setState(() {}); // 🔹 Para actualizar la UI después de obtener los datos
  }
  
  @override
  void initState() {
    super.initState();

    fetchAndSetServices(); // Cargar los servicios desde la API

    // Escuchar cambios en el campo de búsqueda y actualizar la lista en tiempo real
    searchController.addListener(() {
      filterServices();
    });
  }

  void filterServices() {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      setState(() {
        filteredServices = filteredServices;
      });
    } else {
      setState(() {
        filteredServices = filteredServices
            .where((service) => service['title'].toLowerCase().contains(query))
            .toList();
      });
    }
  }

  void selectService(String serviceId, String serviceName) {
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
          Get.off(() => const HomepageWorker()); // Modificado para ir a HomeWorker
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
      return Icons.build;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
