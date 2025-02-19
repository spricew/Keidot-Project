import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/services_request/service_by_name.dart';
import 'package:test_app/Services/transaction/service_transaction_controller.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/request_screen1.dart';
import 'package:test_app/widgets/custom_appbar.dart';
import 'package:test_app/Services/services_request/service_controller.dart';

class SearchScreen extends StatefulWidget {
  final Function(int) onTabSelected;

  const SearchScreen({
    super.key,
    required this.onTabSelected,
  });

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiServiceName apiService = ApiServiceName();
  final TextEditingController searchController = TextEditingController();
  final ServiceController serviceController = Get.find<ServiceController>();
  
  List<Map<String, dynamic>> services = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadServices();
    
    // Escuchar cambios en el campo de búsqueda y actualizar la lista en tiempo real
    searchController.addListener(() {
      filterServices();
    });
  }

  void loadServices() {
    // Carga todos los servicios almacenados en el controlador
    services = serviceController.services.map((s) => s.toJson()).toList();
  }

  void filterServices() async {
    final query = searchController.text.trim();

    if (query.isEmpty) {
      setState(() => loadServices());
      return;
    }

    try {
      final result = await apiService.getServicesByName(query);
      setState(() => services = result);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  void selectService(String serviceId, String serviceName) {
    final serviceTransactionController = Get.find<ServiceTransactionController>();
    serviceTransactionController.setService(serviceId, serviceName);
    Get.to(() => const RequestScreen1());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Búsqueda',
        titleFontSize: 28,
        toolbarHeight: 85,
        backgroundColor: Colors.white,
        titleColor: darkGreen,
        iconColor: darkGreen,
        onBackPressed: () {
          widget.onTabSelected(0);
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
                    color: Colors.grey.withOpacity(0.2),
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
              child: services.isNotEmpty
                  ? ListView.builder(
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        final service = services[index];
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
