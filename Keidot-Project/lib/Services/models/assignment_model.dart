import 'package:intl/intl.dart';

class AssignmentDTO {
  final String idAssignment;
  final String nameOfService;
  final String description;
  final String estimatedSize; // Ahora es un String, no Duration
  final DateTime timeSelected;
  final double amount;
  final String status;
  final DateTime createdAt; // Se agrega la fecha de creación
  final String paymentIntentId; // Se agrega el id del intento de pago
  final String workerId; // Se agrega el id del trabajador

  AssignmentDTO({
    required this.idAssignment,
    required this.nameOfService,
    required this.description,
    required this.estimatedSize,
    required this.timeSelected,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.paymentIntentId,
    required this.workerId,
  });

  /// Formatea la fecha como `16/02/2025`
  String get formattedDateSelected {
    return DateFormat('dd/MM/yyyy').format(timeSelected);
  }

  /// Formatea la hora seleccionada como `03:00 PM`
  String get formattedTimeSelected {
    return DateFormat('hh:mm a').format(timeSelected);
  }

  //Assignet_at formateada porque no lo hizo HeyderMomischis
  /// Formatea la fecha como `16/02/2025`
  String get formattedDatecreatedAt {
    return DateFormat('dd/MM/yyyy').format(createdAt);
  }

  /// Formatea la hora seleccionada como `03:00 PM`
  String get formattedTimecreatedAt {
    return DateFormat('hh:mm a').format(createdAt);
  }

  /// Convierte JSON a `AssignmentDTO`
  factory AssignmentDTO.fromJson(Map<String, dynamic> json) {
    return AssignmentDTO(
      idAssignment: json['id_assignment'] as String,
      nameOfService: json['name_of_service'] as String,
      description: json['description'] as String,
      estimatedSize:
          json['estimated_size'] as String, // Cambiado de Duration a String
      timeSelected: DateTime.parse(json['time_selected']),
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['asigned_at']),
      paymentIntentId: json['payment_intent_id'] as String,
      workerId: json['workerId']  as String? ?? 'default_worker_id',
    );
  }

  /// Convierte `AssignmentDTO` a JSON
  Map<String, dynamic> toJson() {
    return {
      'id_assignment': idAssignment,
      'name_of_service': nameOfService,
      'description': description,
      'estimated_size': estimatedSize, // Ahora se envía como String
      'time_selected': timeSelected.toIso8601String(),
      'amount': amount,
      'status': status,
      'asigned_at': createdAt.toIso8601String(),
      'payment_intent_id': paymentIntentId,
      'workerId': workerId,
    };
  }
}
