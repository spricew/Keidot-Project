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
    serviceController.setServiceId(serviceId); // Guarda el ID en el controlador
    Get.to(() => RequestScreen1(serviceId: serviceId, serviceName: serviceName));
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
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Buscar servicio...",
                prefixIcon: const Icon(Icons.search, color: darkGreen),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
            const SizedBox(height: 12),

            // Botón de búsqueda
            ElevatedButton(
              onPressed: fetchService,
              style: ElevatedButton.styleFrom(
                  backgroundColor: darkGreen, foregroundColor: Colors.white),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Buscar"),
            ),
            const SizedBox(height: 20),

            // Lista de servicios
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : services.isNotEmpty
                      ? ListView.builder(
                          itemCount: services.length,
                          itemBuilder: (context, index) {
                            final service = services[index];
                            final serviceId = service['id'].toString(); // Asegurar que sea String
                            final serviceName = service['title'] ?? "Sin título";

                            return Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Text(
                                  serviceName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () => selectService(serviceId, serviceName), // Enviar ID y Nombre
                              ),
                            );
                          },
                        )
                      : const Center(child: Text("No se encontraron servicios")),
            ),
          ],
        ),
      ),
    );
  }
}
