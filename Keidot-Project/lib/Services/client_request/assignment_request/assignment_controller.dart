import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/models/assignment_model.dart';

class AssignmentIdController extends GetxController {
  final Logger logger = Logger();

  String? _selectedAssignmentId; // Propiedad privada
  String? _selectedpaymentIntentId; // Propiedad privada

  AssignmentDTO?
      _selectedAssignment; // Ahora almacenamos el objeto completo //Quitar

  /// Método para establecer la asignación seleccionada
  ////Quitar
  void setSelectedAllAssignment(AssignmentDTO assignment) {
    _selectedAssignment = assignment;
    logger.i("Asignación seleccionada: ${assignment.idAssignment}");
    update(); // Notifica a la UI si usas GetBuilder
  }

  /// Método para establecer el ID de la asignación seleccionada
  void setSelectedIdAssignment(String assignmentId) {
    _selectedAssignmentId = assignmentId;
    logger.i("Asignación seleccionada: $assignmentId");
  }
  //Metod para guardar el payment_intent_id
  setSelectedpaymentIntentId(String paymentIntentId) {
    _selectedpaymentIntentId = paymentIntentId;
    logger.i("paymentIntentId seleccionada: $paymentIntentId");
  }

  //Quitar
  /// Getter para obtener la asignación seleccionada
  AssignmentDTO? get selectedAssignment => _selectedAssignment;

  /// Getter para obtener el ID de la asignación seleccionada
  String? get selectedAssignmentId => _selectedAssignmentId;

    /// Getter para obtener el paymentIntentId seleccionado
  String? get selectedpaymentIntentId => _selectedpaymentIntentId;
}
