import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/Services/models/assignment_model.dart';
import 'package:test_app/Services/worker_request/assignments_publish/jobs_publish.dart';
import 'package:test_app/presentation/worker/worker_assignment_detail_screen.dart';

class WorkerJobRequestsScreen extends StatefulWidget {
  const WorkerJobRequestsScreen({super.key});

  @override
  _WorkerJobRequestsScreenState createState() => _WorkerJobRequestsScreenState();
}

class _WorkerJobRequestsScreenState extends State<WorkerJobRequestsScreen> {
  final JobsPublishService _jobService = JobsPublishService();
  late Future<List<AssignmentDTO>> _jobsFuture;
  final AssignmentIdController assignmentController = Get.put(AssignmentIdController());

  @override
  void initState() {
    super.initState();
    _jobsFuture = _jobService.fetchAllJobs();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Trabajos Disponibles',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        foregroundColor: colors.primary,
      ),
      body: FutureBuilder<List<AssignmentDTO>>(
        future: _jobsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error al cargar trabajos: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay trabajos disponibles."));
          }

          final jobs = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(3),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.work, color: Colors.green, size: 30),
                  title: Text(
                    job.nameOfService,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    "Ubicación: ${job.status ?? "Desconocida"}\nPago: \$${job.amount?.toStringAsFixed(2) ?? "N/A"}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Acción de aceptar trabajo (pendiente de lógica)////////////////////////////////////
                    // Guarda el ID de la asignación seleccionada
                    assignmentController.setSelectedAssignment(job.idAssignment);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      "Aceptar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {

                    //Aqui va para guardar el id al ser selccionado
                    // Navega a la pantalla de detalles del trabajo
                    Get.to(() => WorkerAssignmentDetailScreen(assignment: job));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
