import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/transaction/service_transaction_controller.dart';
import 'package:test_app/presentation/screens/home_page.dart';
import 'package:test_app/presentation/screens/request_screen2.dart';

class RequestScreen1 extends StatelessWidget {
  const RequestScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return const DetallesServicioPage();
  }
}

class DetallesServicioPage extends StatefulWidget {
  const DetallesServicioPage({super.key});

  @override
  _DetallesServicioPageState createState() => _DetallesServicioPageState();
}

class _DetallesServicioPageState extends State<DetallesServicioPage> {
  final ServiceTransactionController controller = Get.find(); // Obtén el controlador

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
        title: const Text('Jardinería', style: TextStyle(color: Color(0xFF3BA670))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Detalles del servicio',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Paso 1 de 3',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3BA670)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Duración estimada', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Card(
              color: const Color.fromARGB(255, 252, 249, 249),
              child: Column(
                children: [
                  Obx(() => RadioListTile<int>(
                        value: 1,
                        groupValue: controller.requestData.value.tiempoEstimado.inMinutes == 30 ? 1 : 0,
                        onChanged: (value) {
                          controller.setTiempoEstimado(const Duration(minutes: 30)); // Pequeña: 20-30 min
                        },
                        title: const Text('Pequeña - Tiempo Est. 20-30 min'),
                      )),
                  Obx(() => RadioListTile<int>(
                        value: 2,
                        groupValue: controller.requestData.value.tiempoEstimado.inMinutes == 90 ? 2 : 0,
                        onChanged: (value) {
                          controller.setTiempoEstimado(const Duration(minutes: 90)); // Mediana: 1-2 hr
                        },
                        title: const Text('Mediana - Tiempo Est. 1-2 hr'),
                      )),
                  Obx(() => RadioListTile<int>(
                        value: 3,
                        groupValue: controller.requestData.value.tiempoEstimado.inMinutes == 150 ? 3 : 0,
                        onChanged: (value) {
                          controller.setTiempoEstimado(const Duration(minutes: 150)); // Grande: Más de 2 hr
                        },
                        title: const Text('Grande - Tiempo Est. Más de 2 hr'),
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
                    Get.offAll(() => const Homepage()); // Regresa a la pantalla de inicio
                  },
                  child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Valida que se haya seleccionado una duración
                    if (controller.requestData.value.tiempoEstimado.inMinutes <= 0) {
                      Get.snackbar("Error", "Selecciona una duración válida");
                      return;
                    }

                    // Navega a la siguiente pantalla
                    Get.to(() => RequestScreen2());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12372A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: const Text('Siguiente', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}