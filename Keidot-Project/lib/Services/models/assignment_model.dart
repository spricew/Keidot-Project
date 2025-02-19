import 'package:intl/intl.dart';

class AssignmentDTO {
  final String nameOfService;
  final String description;
  final Duration estimatedTime;
  final DateTime timeSelected;
  final double amount;

  AssignmentDTO({
    required this.nameOfService,
    required this.description,
    required this.estimatedTime,
    required this.timeSelected,
    required this.amount,
  });

  /// Formatea la fecha como `16/02/2025`
  String get formattedDateSelected {
    return DateFormat('dd/MM/yyyy').format(timeSelected);
  }

  /// Formatea la hora seleccionada como `03:00 PM`
  String get formattedTimeSelected {
    return DateFormat('hh:mm a').format(timeSelected);
  }

  /// Formatea el tiempo estimado como `30 min` o `2h 15min`
  String get formattedEstimatedTime {
    if (estimatedTime.inHours > 0) {
      return "${estimatedTime.inHours}h ${estimatedTime.inMinutes.remainder(60)}min";
    }
    return "${estimatedTime.inMinutes} min";
  }

  /// Convierte JSON a `AssignmentDTO`
  factory AssignmentDTO.fromJson(Map<String, dynamic> json) {
    var tiempoEstimadoRaw = json['tiempo_estimado'];
    Duration estimatedTime;

    if (tiempoEstimadoRaw is String) {
      try {
        List<String> partes = tiempoEstimadoRaw.split(':');
        if (partes.length == 3) {
          estimatedTime = Duration(
            hours: int.parse(partes[0]),
            minutes: int.parse(partes[1]),
            seconds: int.parse(partes[2]),
          );
        } else {
          throw const FormatException("Formato incorrecto en tiempo_estimado");
        }
      } catch (e) {
        print("Error al parsear tiempo_estimado: $tiempoEstimadoRaw - $e");
        estimatedTime = Duration.zero;
      }
    } else if (tiempoEstimadoRaw is int) {
      estimatedTime = Duration(minutes: tiempoEstimadoRaw);
    } else {
      print("tiempo_estimado tiene un formato desconocido: $tiempoEstimadoRaw");
      estimatedTime = Duration.zero;
    }

    return AssignmentDTO(
      nameOfService: json['name_of_service'],
      description: json['description'],
      estimatedTime: estimatedTime,
      timeSelected: DateTime.parse(json['time_selected']),
      amount: (json['amount'] as num).toDouble(),
    );
  }
}
