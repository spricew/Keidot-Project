import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/client_request/assignment_request/PUT/assignment_cancel_request.dart';
import 'package:test_app/Services/models/assignment_model.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/stripe/stripe_refund.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class AssignmentDetailScreen2 extends StatelessWidget {
  final AssignmentDTO assignment;

  const AssignmentDetailScreen2({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Detalles de la solicitud',
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        titleFontSize: 26,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              assignment.nameOfService,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: darkGreen),
            ),
            const SizedBox(height: 10),

            // Nuevo título para la fecha asignada
            const Text(
              "Fecha asignada para realizar el trabajo:",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 5),
            Text(
              "Fecha: ${assignment.formattedDateSelected}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              "Hora: ${assignment.formattedTimeSelected}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),

            Text(
              "Tamaño estimado del jardin: ${assignment.estimatedSize}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              "Monto: MXN \$${assignment.amount.toStringAsFixed(2)}",
              style: const TextStyle(color: greenContrast, fontSize: 16),
            ),
            const SizedBox(height: 15),

            const Text(
              'Descripción:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              assignment.description,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        // Lógica para terminar trabajo
                        Get.defaultDialog(
                          titlePadding: const EdgeInsets.all(20),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          title: 'Terminar Trabajo',
                          titleStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          content: const Text(
                            '¿Estás seguro de que deseas terminar este trabajo?',
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'Cancelar',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                try {
                                  final AssignmentCancelRequest service =
                                      AssignmentCancelRequest();
                                  bool success = await service.updateIsActive(
                                      context,);

                                  if (!success) {
                                    Get.snackbar(
                                      'Error',
                                      'No se pudo terminar el trabajo.',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                    return;
                                  }

                                  Get.snackbar(
                                    'Trabajo Terminado',
                                    'El trabajo se ha terminado correctamente.',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green[900],
                                    colorText: Colors.white,
                                  );

                                  // 🔹 Agregar un delay antes de cerrar la pantalla
                                  await Future.delayed(const Duration(
                                      seconds:
                                          2)); // Espera 2 segundos antes de cerrar
                                } catch (e) {
                                  Get.snackbar(
                                    'Error',
                                    'Se produjo un error inesperado: $e',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );

                                  await Future.delayed(const Duration(
                                      seconds:
                                          2)); // Espera 2 segundos antes de cerrar
                                } finally {
                                  Get.back(); // 🔹 Ahora se cerrará después del delay
                                }
                              },
                              child: const Text(
                                'Aceptar',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: const Icon(Icons.check, color: Colors.green, size: 20),
                      label: const Text(
                        'Terminar Trabajo',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}