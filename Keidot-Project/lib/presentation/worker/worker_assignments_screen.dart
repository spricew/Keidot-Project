import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/models/assignment_model.dart';
import 'package:test_app/Services/worker_request/jobs_accepted_by_worker/jobs_taken_worker.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/worker/worker_assignment_detail_screen.dart';

class WorkerAssignmentsScreen extends StatefulWidget {
  WorkerAssignmentsScreen({super.key});

  @override
  _WorkerAssignmentsScreenState createState() =>
      _WorkerAssignmentsScreenState();
}

class _WorkerAssignmentsScreenState extends State<WorkerAssignmentsScreen> {
  final AcceptedJobsService _acceptedJobsService = AcceptedJobsService(
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

      logger.i("Recuperando trabajos aceptados para workerId: $workerId");
      final List<dynamic> jobsData =
          await _acceptedJobsService.fetchAcceptedJobs(workerId);

      List<AssignmentDTO> jobs = jobsData
          .map((job) => AssignmentDTO.fromJson(job))
          .toList();

      logger.i("Trabajos aceptados cargados con éxito.");
      return jobs;
    } catch (e) {
      logger.e("Error al recuperar los trabajos aceptados: $e");
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trabajos Aceptados'),
        backgroundColor: defaultWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
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
              itemCount: assignments.length,
              itemBuilder: (context, index) {
                final assignment = assignments[index];
                return ListTile(
                  title: Text(
                    assignment.nameOfService,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: greenHigh,
                    ),
                  ),
                  subtitle: Text(
                    "${assignment.formattedDateSelected} a las ${assignment.formattedTimeSelected}",
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.to(
                        () => WorkerAssignmentDetailScreen(assignment: assignment));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
