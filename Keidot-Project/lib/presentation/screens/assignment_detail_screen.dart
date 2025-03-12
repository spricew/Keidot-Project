import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_is_active_request.dart';
import 'package:test_app/Services/models/assignment_model.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/review_screen.dart';
import 'package:test_app/presentation/screens/stripe/stripe_refund.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class AssignmentDetailScreen extends StatelessWidget {
  final AssignmentDTO assignment;

  const AssignmentDetailScreen({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Detalles de la Solicitud',
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
                      onPressed: () {
                        // Lógica para marcar como terminado
                        Get.defaultDialog(
                          titlePadding: const EdgeInsets.all(20),
                          contentPadding: const EdgeInsets.all(20),
                          title: 'Marcar como Terminado',
                          titleStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          content: const Text(
                            '¿Estás seguro de que deseas marcar esta solicitud como terminada?',
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ReviewScreen()));
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
                        backgroundColor:
                            Colors.green[700], // Color que indica "completado"
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      label: const Text(
                        'Marcar como Terminado',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10), // Espacio entre botones
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        // Lógica para cancelar solicitud
                        Get.defaultDialog(
                          titlePadding: const EdgeInsets.all(20),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          title: 'Cancelar Solicitud',
                          titleStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          content: const Text(
                            '¿Estás seguro de que deseas cancelar esta solicitud?',
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
                                  final UpdateIsActiveService service =
                                      UpdateIsActiveService();
                                  bool success = await service.updateIsActive(
                                      context, false);

                                  if (!success) {
                                    Get.snackbar(
                                      'Error',
                                      'No se pudo cancelar la solicitud.',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                    return;
                                  }

                                  final PaymentRefundService refundService =
                                      PaymentRefundService();
                                  final Map<String, dynamic> response =
                                      await refundService.processRefund(
                                          assignment.paymentIntentId);

                                  if (response['success'] == true) {
                                    Get.snackbar(
                                      'Reembolso Exitoso',
                                      'El reembolso se ha procesado correctamente.',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green[900],
                                      colorText: Colors.white,
                                    );

                                    // 🔹 Agregar un delay antes de cerrar la pantalla
                                    await Future.delayed(const Duration(
                                        seconds:
                                            2)); // Espera 2 segundos antes de cerrar
                                  } else {
                                    Get.snackbar(
                                      'Error en el Reembolso',
                                      response['message'] ??
                                          'Ocurrió un error desconocido.',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: defaultWhite,
                                    );

                                    await Future.delayed(const Duration(
                                        seconds:
                                            2)); // Espera 2 segundos antes de cerrar
                                  }
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
                      icon:
                          const Icon(Icons.cancel, color: Colors.red, size: 20),
                      label: const Text(
                        'Cancelar Solicitud',
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
