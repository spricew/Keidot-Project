import 'package:flutter/material.dart';
import 'package:test_app/Services/services_request/service_by_name.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_appbar.dart';
import 'package:test_app/Services/services_request/service_controller.dart';

class SearchScreen extends StatefulWidget {
  final Function(int) onTabSelected;

  const SearchScreen({super.key, required this.onTabSelected});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiServiceName apiService = ApiServiceName();
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> services = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAllServices();
  }

  void fetchAllServices() async {
    setState(() => isLoading = true);
    try {
      final serviceList = await ApiService.fetchServices();
      setState(() => services = serviceList.map((s) => s.toJson()).toList());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  void fetchService() async {
    final query = searchController.text.trim();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ingresa un título de servicio")),
      );
      return;
    }

    setState(() => isLoading = true);

    final result = await apiService.getServiceByName(query);

    setState(() {
      services = result != null ? [result] : [];
      isLoading = false;
    });
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
                prefixIcon: Icon(Icons.search, color: darkGreen),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
            const SizedBox(height: 12),

            // Botón de búsqueda
            ElevatedButton(
              onPressed: fetchService,
              style: ElevatedButton.styleFrom(backgroundColor: darkGreen),
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Buscar", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),

            // Lista de servicios
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : services.isNotEmpty
                      ? ListView.builder(
                          itemCount: services.length,
                          itemBuilder: (context, index) {
                            final service = services[index];
                            return Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Text(service['title'] ?? "Sin título",
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            );
                          },
                        )
                      : Center(child: Text("No se encontraron servicios")),
            ),
          ],
        ),
      ),
    );
  }
}
