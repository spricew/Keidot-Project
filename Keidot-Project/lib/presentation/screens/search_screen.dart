import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importante para la navegación
import 'package:test_app/Services/services_request/service_by_name.dart';
import 'package:test_app/Services/transaction/service_transaction_controller.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/request_screen1.dart';
import 'package:test_app/widgets/custom_appbar.dart';
import 'package:test_app/Services/services_request/service_get_request.dart';

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
  List<Map<String, dynamic>> services = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAllServices();
  }

  Future<void> fetchAllServices() async {
    setState(() => isLoading = true);
    try {
      final serviceList = await ApiService.fetchServices();
      setState(() => services = serviceList.map((s) => s.toJson()).toList());
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> fetchService() async {
    final query = searchController.text.trim();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ingresa un título de servicio")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final result = await apiService.getServiceByName(query);
      setState(() => services = result != null ? [result] : []);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  void selectService(String serviceId, String serviceName) {
    final serviceController = Get.find<ServiceTransactionController>();
    serviceController.setService(
        serviceId, serviceName); // Guarda ambos valores
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

            // Botón de búsqueda
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: fetchService,
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkGreen,
                  foregroundColor: Colors.white, // Color del texto y del ícono
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                icon: const Icon(
                  Icons.search,
                  size: 24,
                  color: Colors.white, // Color del ícono
                ),
                label: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Buscar",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold, // Texto en negrita
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),

            // Lista de servicios
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: darkGreen,
                        strokeWidth: 3,
                      ),
                    )
                  : services.isNotEmpty
                      ? ListView.builder(
                          itemCount: services.length,
                          itemBuilder: (context, index) {
                            final service = services[index];
                            final serviceId = service['service_id']
                                .toString(); // Asegurar que sea String
                            final serviceName =
                                service['title'] ?? "Sin título";
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () =>
                                    selectService(serviceId, serviceName),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Icon(
                                        _getServiceIcon(
                                            serviceName), // Ícono relacionado
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
}
