import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AssignmentIdController extends GetxController {
  final Logger logger = Logger();
  
  String? _selectedAssignmentId; // Propiedad privada

  /// Método para establecer el ID de la asignación seleccionada
  void setSelectedAssignment(String assignmentId) {
    _selectedAssignmentId = assignmentId;
    logger.i("Asignación seleccionada: $assignmentId");
  }

  /// Getter para obtener el ID de la asignación seleccionada
  String? get selectedAssignmentId => _selectedAssignmentId;
}
