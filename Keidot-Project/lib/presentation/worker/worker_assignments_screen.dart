import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/worker/worker_assignment_detail_screen.dart';
import 'package:test_app/Services/models/assignment_model.dart'; // Asegúrate de que esta ruta sea correcta

class WorkerAssignmentsScreen extends StatelessWidget {
  WorkerAssignmentsScreen({Key? key}) : super(key: key);

  // Lista de trabajos aceptados (dummy data)
  final List<AssignmentDTO> assignments = [
    AssignmentDTO(
      idAssignment: "1",
      nameOfService: "Corte de césped",
      description: "Corte de césped en jardín pequeño.",
      estimatedSize: "50 m²",
      timeSelected: DateTime(2025, 8, 1, 10, 0),
      amount: 250.00,
    ),
    AssignmentDTO(
      idAssignment: "2",
      nameOfService: "Limpieza de jardín",
      description: "Limpieza completa de jardín.",
      estimatedSize: "100 m²",
      timeSelected: DateTime(2025, 8, 3, 14, 0),
      amount: 400.00,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trabajos Aceptados'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView.builder(
        itemCount: assignments.length,
        itemBuilder: (context, index) {
          final assignment = assignments[index];
          return ListTile(
            title: Text(
              assignment.nameOfService,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            subtitle: Text(
              "${assignment.formattedDateSelected} a las ${assignment.formattedTimeSelected}",
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navega a la pantalla de detalles del trabajo
              Get.to(() => WorkerAssignmentDetailScreen(assignment: assignment));
            },
          );
        },
      ),
    );
  }
}
