import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/Services/models/worker_profile.dart';
import 'package:test_app/Services/worker_request/profile_worker/profile_worker.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/review_for_client.dart';

class WorkerProfileScreen extends StatefulWidget {
  const WorkerProfileScreen({super.key});

  @override
  _ClientProfileScreenState createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<WorkerProfileScreen> {
  final ProfileWorkerService _service = ProfileWorkerService();
  final AssignmentIdController _assignmentIdController =
      Get.find<AssignmentIdController>();
  late Future<ProfileWorkerDTO?> _profileFuture;

  @override
  void initState() {
    super.initState();
    final workerId = _assignmentIdController.selectedWorkerId;
    if (workerId != null) {
      _profileFuture = _service.getProfileWorkerById(workerId);
    } else {
      _profileFuture = Future.error('No se encontró el Worker ID.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultWhite,
        title: const Text('Perfil del Trabajador',
            style: TextStyle(color: darkGreen)),
      ),
      body: FutureBuilder<ProfileWorkerDTO?>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null) {
            return const Center(
                child: Text('No se encontraron datos del trabajador.'));
          }

          final profile = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: greenContrast,
                    child: Text(
                      profile.fullname.substring(0, 1),
                      style: const TextStyle(fontSize: 40, color: defaultWhite),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildProfileInfo('Nombre', profile.fullname),
                _buildProfileInfo(
                    'Años de Experiencia', '${profile.experienceYears}'),
                _buildProfileInfo('Correo Electrónico', profile.email),
                _buildProfileInfo('Teléfono', '${profile.phone}'),
                _buildProfileInfo('Biografía', profile.bio),

                const Spacer(), // Para empujar el botón al fondo
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.to(() => ReviewsForClientScreen());
                    },
                    icon: const Icon(Icons.reviews, color: Colors.white),
                    label: const Text(
                      "Ver Reseñas",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenHigh,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: darkGreen),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
