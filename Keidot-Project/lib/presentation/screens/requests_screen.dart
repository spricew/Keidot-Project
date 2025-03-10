import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_request.dart';
import 'package:test_app/Services/models/assignment_model.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/assignment_detail_screen.dart';
import 'package:test_app/presentation/screens/home_page.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  _RequestsScreenState createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  late Future<List<AssignmentDTO>> _assignmentsFuture;
  final AssignmentService _service = AssignmentService();
  final AssignmentIdController _assignmentIdController = Get.find<AssignmentIdController>(); 
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
        title: 'Solicitudes',
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
                return const Center(child: Text('No hay solicitudes disponibles.'));
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
    return GestureDetector(
      onTap: () {
        _assignmentIdController.setSelectedIdAssignment(assignment.idAssignment);
        _logger.i("Assignment ID seleccionado: ${assignment.idAssignment}");
        _assignmentIdController.setSelectedpaymentIntentId(assignment.paymentIntentId);
        _logger.i("paymentIntentId seleccionado: ${assignment.paymentIntentId}");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssignmentDetailScreen(assignment: assignment),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400, width: 1),
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const Icon(Icons.work, size: 30, color: Colors.green),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assignment.nameOfService,
                    style: const TextStyle(
                        color: Colors.green,
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
                    style: const TextStyle(color: Colors.green, fontSize: 14),
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
