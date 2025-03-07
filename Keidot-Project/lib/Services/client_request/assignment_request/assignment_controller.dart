import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/models/assignment_model.dart';

class AssignmentIdController extends GetxController {
  final Logger logger = Logger();

  String? _selectedAssignmentId; // Propiedad privada

    AssignmentDTO? _selectedAssignment; // Ahora almacenamos el objeto completo //Quitar

  /// Método para establecer la asignación seleccionada
  ////Quitar
  void setSelectedAllAssignment(AssignmentDTO assignment) {
    _selectedAssignment = assignment;
    logger.i("Asignación seleccionada: ${assignment.idAssignment}");
    update(); // Notifica a la UI si usas GetBuilder
  }
///Quitar

  /// Método para establecer el ID de la asignación seleccionada
  void setSelectedAssignment(String assignmentId) {
    _selectedAssignmentId = assignmentId;
    logger.i("Asignación seleccionada: $assignmentId");
  }
  
  //Quitar
  /// Getter para obtener la asignación seleccionada
  AssignmentDTO? get selectedAssignment => _selectedAssignment;
  //Quitar

  /// Getter para obtener el ID de la asignación seleccionada
  String? get selectedAssignmentId => _selectedAssignmentId;
}
