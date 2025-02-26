import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/transaction/service_transaction_controller.dart';
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

  @override
  void initState() {
    super.initState(); // Guardar el serviceId
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
          controller
              .serviceName(), // Muestra el título del servicio en la barra superior
          style: const TextStyle(color: Color(0xFF3BA670), fontSize: 18),
          maxLines: 1,
          overflow:
              TextOverflow.ellipsis, // Para evitar que se corte si es largo
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
                        title: const Text('Pequeño'),
                      )),
                  Obx(() => RadioListTile<String>(
                        value: "Mediano",
                        groupValue: controller.transaction.value.estimatedSize,
                        onChanged: (value) {
                          if (value != null) {
                            controller.setEstimatedSize(value);
                          }
                        },
                        title: const Text('Mediano'),
                      )),
                  Obx(() => RadioListTile<String>(
                        value: "Grande",
                        groupValue: controller.transaction.value.estimatedSize,
                        onChanged: (value) {
                          if (value != null) {
                            controller.setEstimatedSize(value);
                          }
                        },
                        title: const Text('Grande'),
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
                      Get.snackbar("Error", "Seleccione una tamaño válido");//Enviar datos de la seleccion de las caracteristicas
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
