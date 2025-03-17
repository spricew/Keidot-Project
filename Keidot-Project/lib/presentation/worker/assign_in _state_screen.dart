import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/Services/models/assignment_model.dart';
import 'package:test_app/Services/worker_request/jobs_pending/in_state_request.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/worker/ubicacion_assignment_detail_screen.dart';

class AssignInStateRequest extends StatefulWidget {
  const AssignInStateRequest({super.key});

  @override
  _AssignInStateRequest createState() =>
      _AssignInStateRequest();
}

class _AssignInStateRequest extends State<AssignInStateRequest> {
  final AssignInStateService _assignInStateService = AssignInStateService(
    storage: const FlutterSecureStorage(),
  );

  final Logger logger = Logger();
  late Future<List<AssignmentDTO>> _assignmentsFuture;

  @override
  void initState() {
    super.initState();
    _assignmentsFuture = _fetchAcceptedJobs();
  }

  Future<List<AssignmentDTO>> _fetchAcceptedJobs() async {
    try {
      String? workerId = await const FlutterSecureStorage().read(key: "userId");

      if (workerId == null) {
        logger.e("workerId no encontrado en el almacenamiento seguro.");
        throw Exception("workerId no encontrado.");
      }

      logger.i("Recuperando trabajos solicitados por workerId: $workerId");
      final List<dynamic> jobsData =
          await _assignInStateService.fetchInStateService(workerId);

      List<AssignmentDTO> jobs =
          jobsData.map((job) => AssignmentDTO.fromJson(job)).toList();

      logger.i("Trabajos solicitados cargados con éxito.");
      return jobs;
    } catch (e) {
      logger.e("Error al recuperar los trabajos solicitados: $e");
      return [];
    }
  }

  Future<void> _refreshAssignments() async {
    setState(() {
      _assignmentsFuture = _fetchAcceptedJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trabajos Solicitados',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        foregroundColor: colors.primary,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshAssignments,
        child: FutureBuilder<List<AssignmentDTO>>(
          future: _assignmentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error al cargar trabajos: ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No hay trabajos aceptados."));
            }

            final assignments = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(3),
              itemCount: assignments.length,
              itemBuilder: (context, index) {
                final assignment = assignments[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: const Icon(Icons.work, color: greenHigh, size: 30),
                    title: Text(
                      assignment.nameOfService,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fecha: ${assignment.formattedDateSelected}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Hora: ${assignment.formattedTimeSelected}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Pago: \$${assignment.amount.toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        final AssignmentIdController assignmentController =
                            Get.put(AssignmentIdController());

                        // Guardar el ID de la asignación seleccionada
                        assignmentController.setSelectedIdAssignment(assignment.idAssignment);

                        // Navegar a la pantalla de detalles
                        Get.to(() =>
                            WorkerAssignmentDetailScreen(assignment: assignment));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenHigh,
                      ),
                      child: const Text(
                        "Detalles",
                        style: TextStyle(color: defaultWhite),
                      ),
                    ),
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
