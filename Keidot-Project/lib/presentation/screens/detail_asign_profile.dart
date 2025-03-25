import 'package:flutter/material.dart';
import 'package:test_app/Services/client_request/assignment_request/PUT/rejected_job.dart';
import 'package:test_app/Services/client_request/assignment_request/PUT/request_success_Client.dart';
import 'package:test_app/Services/models/assignment_model.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/worker_profileForClient_screen.dart';

class AssignmentProfileDetailScreen extends StatelessWidget {
  final AssignmentDTO assignment;

  const AssignmentProfileDetailScreen({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Solicitud'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assignment.nameOfService,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkGreen),
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _acceptAssignment(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Aceptar',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _rejectAssignment(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Rechazar',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _viewWorkerProfile(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Ver Perfil',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _acceptAssignment(BuildContext context) async {
    final AssignmentSuccess assignmentSuccess = AssignmentSuccess();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aceptar Solicitud'),
        content:
            const Text('¿Estás seguro de que deseas aceptar esta solicitud?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              bool isAccepted = await assignmentSuccess.updateIsActive(context);

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Resultado'),
                  content: Text(isAccepted
                      ? 'Solicitud aceptada correctamente.'
                      : 'Error al aceptar la solicitud. Inténtalo de nuevo.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _rejectAssignment(BuildContext context) async {
    final AssignmentRejected assignmentRejected = AssignmentRejected();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rechazar Solicitud'),
        content:
            const Text('¿Estás seguro de que deseas rechazar esta solicitud?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              bool isRejected =
                  await assignmentRejected.updateIsActive(context);

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Resultado'),
                  content: Text(isRejected
                      ? 'Solicitud rechazada correctamente.'
                      : 'Error al rechazar la solicitud. Inténtalo de nuevo.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Rechazar'),
          ),
        ],
      ),
    );
  }

  void _viewWorkerProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Información'),
        content: const Text('Navegando al perfil del trabajador...'),
      ),
    );

    // Espera 1 segundo, cierra el diálogo y navega
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop(); // Cierra el AlertDialog
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const WorkerProfileForClientScreen()),
      );
    });
  }
}
