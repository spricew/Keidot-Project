import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/config/theme/app_theme.dart';

class ServiceRequestsScreen extends StatefulWidget {
  final String serviceName;
  const ServiceRequestsScreen({Key? key, required this.serviceName})
      : super(key: key);

  @override
  _ServiceRequestsScreenState createState() => _ServiceRequestsScreenState();
}

class _ServiceRequestsScreenState extends State<ServiceRequestsScreen> {
  int? selectedIndex; // Índice de la solicitud seleccionada

  @override
  Widget build(BuildContext context) {
    // Ejemplos de solicitudes para el servicio seleccionado (dummy data)
    final List<String> requests = [
      "${widget.serviceName} - Solicitud 1: Ejemplo de solicitud.",
      "${widget.serviceName} - Solicitud 2: Ejemplo de solicitud.",
      "${widget.serviceName} - Solicitud 3: Ejemplo de solicitud.",
      "${widget.serviceName} - Solicitud 4: Ejemplo de solicitud.",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Servicios destacados: ${widget.serviceName}',
          style: const TextStyle(
            color: greenHigh,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: RadioListTile<int>(
                    value: index,
                    groupValue: selectedIndex,
                    onChanged: (int? value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                    title: Text(
                      requests[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: greenHigh,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: selectedIndex != null
                  ? () {
                      // Acción al confirmar: muestra un snackbar con la selección
                      Get.snackbar(
                        "Confirmación",
                        "Has seleccionado: ${requests[selectedIndex!]}",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  : null,
              child: const Text(
                "Confirmar selección",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
