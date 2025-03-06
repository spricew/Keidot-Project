import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/models/assignment_model.dart';
import 'package:test_app/config/theme/app_theme.dart';

class WorkerAssignmentDetailScreen extends StatelessWidget {
  final AssignmentDTO assignment;

  const WorkerAssignmentDetailScreen({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Trabajo'),
        backgroundColor: defaultWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
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
              style: const TextStyle(fontSize: 16, color: greenContrast),
            ),
            const SizedBox(height: 5),
            Text(
              "Hora: ${assignment.formattedTimeSelected}",
              style: const TextStyle(fontSize: 16, color:greenContrast),
            ),
            const SizedBox(height: 10),
            Text(
              "Tamaño estimado del jardín: ${assignment.estimatedSize}",
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
             const Spacer(), // Empuja el botón hacia abajo
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Acción del botón
                Get.snackbar("Acción", "Botón presionado");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                "Ver ubicacion",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
