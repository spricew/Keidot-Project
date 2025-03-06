import 'package:intl/intl.dart';

class AssignmentDTO {
  final String idAssignment;
  final String nameOfService;
  final String description;
  final String estimatedSize; // Ahora es un String, no Duration
  final DateTime timeSelected;
  final double amount;
  final String status;

  AssignmentDTO({
    required this.idAssignment,
    required this.nameOfService,
    required this.description,
    required this.estimatedSize,
    required this.timeSelected,
    required this.amount,
    required this.status
  });

  /// Formatea la fecha como `16/02/2025`
  String get formattedDateSelected {
    return DateFormat('dd/MM/yyyy').format(timeSelected);
  }

  /// Formatea la hora seleccionada como `03:00 PM`
  String get formattedTimeSelected {
    return DateFormat('hh:mm a').format(timeSelected);
  }

  /// Convierte JSON a `AssignmentDTO`
  factory AssignmentDTO.fromJson(Map<String, dynamic> json) {
    return AssignmentDTO(
      idAssignment: json['id_assignment'] as String,
      nameOfService: json['name_of_service'] as String,
      description: json['description'] as String,
      estimatedSize: json['estimated_size'] as String, // Cambiado de Duration a String
      timeSelected: DateTime.parse(json['time_selected']),
      amount: (json['amount'] as num).toDouble(),
      status:  json['status'] as String,
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
      'status': status
    };
  }
}
