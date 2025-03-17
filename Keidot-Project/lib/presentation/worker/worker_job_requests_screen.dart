import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/Services/models/assignment_model.dart';
import 'package:test_app/Services/worker_request/applying_fo_a_job/request_for_job.dart';
import 'package:test_app/Services/worker_request/assignments_publish/jobs_publish.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/worker/ubicacion_assignment_detail_screen.dart';

//Listado de todos los trabajos disponibles

class WorkerJobRequestsScreen extends StatefulWidget {
  const WorkerJobRequestsScreen({super.key});

  @override
  _WorkerJobRequestsScreenState createState() =>
      _WorkerJobRequestsScreenState();
}

class _WorkerJobRequestsScreenState extends State<WorkerJobRequestsScreen> {
  final JobsPublishService _jobService = JobsPublishService();
  late Future<List<AssignmentDTO>> _jobsFuture;
  final AssignmentIdController assignmentController =
      Get.put(AssignmentIdController());

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  // Método para cargar trabajos
  void _loadJobs() {
    setState(() {
      _jobsFuture = _jobService.fetchAllJobs();
    });
  }

  // Método para refrescar los trabajos
  Future<void> _refreshJobs() async {
    _loadJobs();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trabajos Disponibles',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        foregroundColor: colors.primary,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshJobs, // Se ejecuta al arrastrar hacia abajo
        child: FutureBuilder<List<AssignmentDTO>>(
          future: _jobsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text("Error al cargar trabajos: ${snapshot.error}"));
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
                    leading: const Icon(Icons.work, color: greenHigh, size: 30),
                    title: Text(
                      job.nameOfService,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      "Tamaño Estimado: ${job.estimatedSize ?? "Desconocida"}\nPago: \$${job.amount.toStringAsFixed(2) ?? "N/A"}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () async {
                        // Guarda el ID de la asignación seleccionada
                        assignmentController
                            .setSelectedIdAssignment(job.idAssignment);

                        // Crear instancia de AssignmentService
                        final assignmentService = AssignmentAcceptedByWorker(
                          baseUrl: "https://keidot.azurewebsites.net",
                          storage: const FlutterSecureStorage(),
                        );

                        // Actualizar el estado a "En progreso"
                        bool success = await assignmentService
                            .updateAssignmentStatus(); // Actualiza el estado de la asignación envindo el ID del trabajador para ntificar que ha sido aceptado

                        // Mostrar mensaje al usuario
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Solicititando trabajo.')), 
                          );
                             ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('El cliente puede tardar en aceptar su solictud.')), 
                          );

                          // **Eliminar el trabajo de la lista sin recargar toda la pantalla**
                          setState(() {
                            jobs.removeAt(index);
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('No puedes aceptar tus trabajos publicados.')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenHigh,
                      ),
                      child: const Text(
                        "Solicitar",
                        style: TextStyle(color: defaultWhite),
                      ),
                    ),
                    onTap: () {
                      // Navega a la pantalla de detalles del trabajo
                      Get.to(
                          () => WorkerAssignmentDetailScreen(assignment: job));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
