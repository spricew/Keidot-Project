import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/client_request/services_request/service_controller.dart';
import 'package:test_app/Services/client_request/transaction/service_transaction_controller.dart';
import 'package:test_app/presentation/screens/home_page.dart';
import 'request_details_garden.dart';

class RequestScreen1 extends StatelessWidget {
  const RequestScreen1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const DetallesServicioPage();
  }
}

class DetallesServicioPage extends StatefulWidget {
  const DetallesServicioPage({
    super.key,
  });

  @override
  _DetallesServicioPageState createState() => _DetallesServicioPageState();
}

class _DetallesServicioPageState extends State<DetallesServicioPage> {
  final ServiceTransactionController controller = Get.find();
  final ServiceController serviceController = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 34,
          ),
          onPressed: () {
            Get.offAll(() => const Homepage());
          },
        ),
        centerTitle: true,
        title: Text(
          controller.serviceName(),
          style: const TextStyle(color: Color(0xFF3BA670), fontSize: 18),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Detalles del jardín',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Paso 1 de 3',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3BA670)),
              ),
            ),
            const SizedBox(height: 46),
            Obx(() {
              if (serviceController.isLoading.value) {
                return const Center(
                  child:
                      CircularProgressIndicator(), // Muestra un indicador de carga mientras se obtienen los servicios
                );
              }

              // Verifica si la lista de servicios está vacía
              if (serviceController.services.isEmpty) {
                return const Center(
                  child: Text(
                      "No hay servicios disponibles"), // Muestra un mensaje si no hay servicios
                );
              }

              return SizedBox(
                width: sizeW,
                child: DropdownButtonFormField<String>(
                  value: controller.transaction.value.serviceId.isEmpty ?? true
                      ? null // Si el serviceId es nulo o vacío, usa null como valor inicial
                      : controller.transaction.value
                          .serviceId, // Usa el ID desde la transacción
                  decoration: InputDecoration(
                    labelText: 'Selecciona un servicio',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 16),
                  ),
                  items: serviceController.services.map((service) {
                    return DropdownMenuItem(
                      value: service
                          .serviceId, // Usa el serviceId como valor del DropdownMenuItem
                      child: Text(service
                          .title), // Muestra el título del servicio en el dropdown
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      final selectedService = serviceController.services
                          .firstWhere((service) => service.serviceId == value);
                      final serviceTransactionController =
                          Get.find<ServiceTransactionController>();
                      serviceTransactionController.setService(
                          value,
                          selectedService
                              .title); // Guarda el serviceId y el nombre del servicio
                    }
                  },
                  hint: const Text(
                      "Seleccione un servicio"), // Texto de sugerencia
                ),
              );
            }),
            const SizedBox(height: 20),
            const Text('Tamaño del jardín',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Card(
              color: const Color.fromARGB(255, 252, 249, 249),
              child: Column(
                children: [
                  Obx(() => RadioListTile<String>(
                        value: "Pequeño (1 m² - 50 m²)",
                        groupValue: controller.transaction.value.estimatedSize,
                        onChanged: (value) {
                          if (value != null) {
                            controller.setEstimatedSize(value);
                            controller.transaction.update((trx) {
                              trx?.amount = (trx?.amount ?? 0) * 5;
                            });
                          }
                        },
                        title: const Text('Pequeño (1 m² - 50 m²)'),
                      )),
                  Obx(() => RadioListTile<String>(
                        value: "Mediano (51 m² - 150 m²)",
                        groupValue: controller.transaction.value.estimatedSize,
                        onChanged: (value) {
                          if (value != null) {
                            controller.setEstimatedSize(value);
                            controller.transaction.update((trx) {
                              trx?.amount = (trx?.amount ?? 0) * 8;
                            });
                          }
                        },
                        title: const Text('Mediano (51 m² - 150 m²)'),
                      )),
                  Obx(() => RadioListTile<String>(
                        value: "Grande (Más de 150 m²)",
                        groupValue: controller.transaction.value.estimatedSize,
                        onChanged: (value) {
                          if (value != null) {
                            controller.setEstimatedSize(value);
                            controller.transaction.update((trx) {
                              trx?.amount = (trx?.amount ?? 0) * 11;
                            });
                          }
                        },
                        title: const Text('Grande (Más de 150 m²)'),
                      )),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.offAll(() => const Homepage());
                  },
                  child: const Text('Cancelar',
                      style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (controller.transaction.value.estimatedSize.isEmpty) {
                      Get.snackbar("Error", "Seleccione un tamaño válido");
                      return;
                    }
                    Get.to(() => const RequestDetailsGarden());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12372A),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: const Text('Siguiente',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
