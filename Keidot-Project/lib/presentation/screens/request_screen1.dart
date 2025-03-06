import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final RxList<String> selectedJobs = <String>[].obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
            const SizedBox(height: 16),
            
            // Nueva Sección: Selección de trabajo
            const Text('Selección de trabajo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Card(
              color: const Color.fromARGB(255, 252, 249, 249),
              child: Column(
                children: [
                  Obx(() => CheckboxListTile(
                        value: selectedJobs.contains('Corte de césped'),
                        onChanged: (value) {
                          if (value == true) {
                            selectedJobs.add('Corte de césped');
                          } else {
                            selectedJobs.remove('Corte de césped');
                          }
                        },
                        title: const Text('Corte de césped'),
                      )),
                  Obx(() => CheckboxListTile(
                        value: selectedJobs.contains('Control de plagas y enfermedades'),
                        onChanged: (value) {
                          if (value == true) {
                            selectedJobs.add('Control de plagas y enfermedades');
                          } else {
                            selectedJobs.remove('Control de plagas y enfermedades');
                          }
                        },
                        title: const Text('Control de plagas y enfermedades'),
                      )),
                  Obx(() => CheckboxListTile(
                        value: selectedJobs.contains('Poda de árboles y arbustos'),
                        onChanged: (value) {
                          if (value == true) {
                            selectedJobs.add('Poda de árboles y arbustos');
                          } else {
                            selectedJobs.remove('Poda de árboles y arbustos');
                          }
                        },
                        title: const Text('Poda de árboles y arbustos'),
                      )),
                  Obx(() => CheckboxListTile(
                        value: selectedJobs.contains('Limpieza de jardín'),
                        onChanged: (value) {
                          if (value == true) {
                            selectedJobs.add('Limpieza de jardín');
                          } else {
                            selectedJobs.remove('Limpieza de jardín');
                          }
                        },
                        title: const Text('Limpieza de jardín'),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Sección: Tamaño del jardín
            const Text('Tamaño del jardín',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Card(
              color: const Color.fromARGB(255, 252, 249, 249),
              child: Column(
                children: [
                  Obx(() => RadioListTile<String>(
                        value: "Pequeño",
                        groupValue: controller.transaction.value.estimatedSize,
                        onChanged: (value) {
                          if (value != null) {
                            controller.setEstimatedSize(value);
                          }
                        },
                        title: const Text('Pequeño (1 m² - 50 m²)'),
                      )),
                  Obx(() => RadioListTile<String>(
                        value: "Mediano",
                        groupValue: controller.transaction.value.estimatedSize,
                        onChanged: (value) {
                          if (value != null) {
                            controller.setEstimatedSize(value);
                          }
                        },
                        title: const Text('Mediano (51 m² - 150 m²)'),
                      )),
                  Obx(() => RadioListTile<String>(
                        value: "Grande",
                        groupValue: controller.transaction.value.estimatedSize,
                        onChanged: (value) {
                          if (value != null) {
                            controller.setEstimatedSize(value);
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
