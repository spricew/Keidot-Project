import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Services/assignment_request/assignment_inact_request.dart';
import 'package:test_app/Services/models/assignment_model.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/assignment_detail_screen.dart';
import 'package:test_app/providers/user_provider.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({super.key});

  @override
  _ClientProfileScreenState createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  final AssignmentInactiveController _controller =
      AssignmentInactiveController();
  late Future<List<AssignmentDTO>> _assignmentsFuture;
  
  @override
  void initState() {
    super.initState();
    _assignmentsFuture = _controller.getAssignments();
  }

  @override
  Widget build(BuildContext context) {
    final name = Provider.of<UserProvider>(context).userName ?? "Usuario";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultWhite,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(color: greenContrast),
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 50, color: darkGreen),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Hola, $name!",
                          style: const TextStyle(
                              color: defaultWhite,
                              fontWeight: FontWeight.w600,
                              fontSize: 22),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Historial de servicios',
                  style: TextStyle(fontSize: 20, color: darkGreen),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          FutureBuilder<List<AssignmentDTO>>(
            future: _assignmentsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                    child: Center(child: Text('Error: ${snapshot.error}')));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SliverToBoxAdapter(
                    child: Center(child: Text('No hay servicios inactivos.')));
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final assignment = snapshot.data![index];
                    return _buildAssignmentCard(assignment, context);
                  },
                  childCount: snapshot.data!.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentCard(AssignmentDTO assignment, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AssignmentDetailScreen(assignment: assignment),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 21),
        decoration: const BoxDecoration(
          color: defaultWhite,
          border: Border(
            top: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 201, 201, 201),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.work, size: 25, color: darkGreen),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assignment.nameOfService,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Fecha: ${assignment.formattedDateSelected}",
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Hora: ${assignment.formattedTimeSelected}",
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "MXN \$${assignment.amount.toStringAsFixed(2)}",
                  style: const TextStyle(color: darkGreen, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
