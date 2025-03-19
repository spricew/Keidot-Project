import 'package:flutter/material.dart';
import 'package:test_app/Services/client_request/assignment_request/PUT/rejected_job.dart';
import 'package:test_app/Services/client_request/assignment_request/PUT/request_success_Client.dart';
import 'package:test_app/Services/models/assignment_model.dart';
import 'package:test_app/config/theme/app_theme.dart';

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
                ],
              ),
            ),
          ),

          // Botones en la parte inferior
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Botón para aceptar
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Lógica para aceptar la solicitud
                      _acceptAssignment(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Color verde para aceptar
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Aceptar',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre botones

                // Botón para rechazar
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Lógica para rechazar la solicitud
                      _rejectAssignment(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Color rojo para rechazar
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Rechazar',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre botones

                // Botón para ver el perfil del trabajador
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Lógica para ver el perfil del trabajador
                      _viewWorkerProfile(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Color azul para ver perfil
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

  // Método para aceptar la solicitud
  void _acceptAssignment(BuildContext context) {
  final AssignmentSuccess assignmentSuccess = AssignmentSuccess(); // Instancia del servicio

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Aceptar Solicitud'),
      content: const Text('¿Estás seguro de que deseas aceptar esta solicitud?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context); // Cerrar el diálogo

            // Llamar al servicio para aceptar la solicitud
            bool isAccepted = await assignmentSuccess.updateIsActive(context);

            if (isAccepted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Solicitud aceptada correctamente.')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error al aceptar la solicitud. Inténtalo de nuevo.')),
              );
            }
          },
          child: const Text('Aceptar'),
        ),
      ],
    ),
  );
}

  // Método para rechazar la solicitud
  void _rejectAssignment(BuildContext context) {
    final AssignmentRejected assignmentRejected = AssignmentRejected(); // Instancia del servicio

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rechazar Solicitud'),
        content: const Text('¿Estás seguro de que deseas rechazar esta solicitud?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Cerrar el diálogo

              // Llamar al servicio para rechazar la solicitud
              bool isRejected = await assignmentRejected.updateIsActive(context);

              if (isRejected) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Solicitud rechazada correctamente.')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error al rechazar la solicitud. Inténtalo de nuevo.')),
                );
              }
            },
            child: const Text('Rechazar'),
          ),
        ],
      ),
    );
  }
}

  // Método para ver el perfil del trabajador
  void _viewWorkerProfile(BuildContext context) {
    // Aquí puedes agregar la lógica para navegar a la pantalla del perfil del trabajador
    // Por ejemplo, usar Navigator.push para ir a otra pantalla
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navegando al perfil del trabajador...')),
    );
  }