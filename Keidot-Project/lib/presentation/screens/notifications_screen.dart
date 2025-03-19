import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/client_request/assignment_request/GET/assignment_in_pending.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/Services/models/assignment_model.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/detail_asign_profile.dart';
import 'package:test_app/presentation/screens/home_page.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class PendingWorkScreen extends StatefulWidget {
  const PendingWorkScreen({super.key});

  @override
  _PendingWorkScreenState createState() => _PendingWorkScreenState();
}

class _PendingWorkScreenState extends State<PendingWorkScreen> {
  late Future<List<AssignmentDTO>> _assignmentsFuture;
  final AssignmentInPending _service = AssignmentInPending();
  final AssignmentIdController _assignmentIdController =
      Get.find<AssignmentIdController>();
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _assignmentsFuture = _service.getAssignments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Trabajos por aceptar',
        backgroundColor: defaultWhite,
        titleFontSize: 25,
        onBackPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Homepage())),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _assignmentsFuture = _service.getAssignments();
          });
          await _assignmentsFuture;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: FutureBuilder<List<AssignmentDTO>>(
            future: _assignmentsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text('No hay solicitudes disponibles.'));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final assignment = snapshot.data![index];
                  return _buildRequestCard(assignment, context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard(AssignmentDTO assignment, BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        _assignmentIdController
            .setSelectedIdAssignment(assignment.idAssignment);
            
        _assignmentIdController
            .setSelectedpaymentIntentId(assignment.paymentIntentId);

        _assignmentIdController.setSelectedIdWorker(assignment.workerId);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AssignmentProfileDetailScreen(assignment: assignment),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 1),
          color: colors.onPrimary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(Icons.work, size: 30, color: colors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assignment.nameOfService,
                    style: TextStyle(
                        color: colors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Fecha: ${assignment.formattedDateSelected}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Hora: ${assignment.formattedTimeSelected}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'MXN \$${assignment.amount.toStringAsFixed(2)}',
                    style: TextStyle(color: colors.primary, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
