import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/assignment_request/assignment_is_active_request.dart';
import 'package:test_app/Services/models/assignment_model.dart';
import 'package:test_app/config/theme/app_theme.dart';

class AssignmentInactiveDetailScreen extends StatelessWidget {
  final AssignmentDTO assignment;

  const AssignmentInactiveDetailScreen({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Solicitud'),
        backgroundColor: Colors.white,
        elevation: 0,
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
              "Tiempo estimado: ${assignment.formattedEstimatedTime}",
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
          ],
        ),
      ),
    );
  }
}
