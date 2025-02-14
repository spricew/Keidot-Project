class AssignmentDTO {
  final String nameOfService;
  final DateTime dateOfAssigned;
  final String description;
  final Duration estimatedTime;
  final String timeSelected;
  final double amount;

  AssignmentDTO({
    required this.nameOfService,
    required this.dateOfAssigned,
    required this.description,
    required this.estimatedTime,
    required this.timeSelected,
    required this.amount,
  });

  // Método para convertir un JSON a un objeto AssignmentDTO
  factory AssignmentDTO.fromJson(Map<String, dynamic> json) {
    return AssignmentDTO(
      nameOfService: json['name_of_service'],
      dateOfAssigned: DateTime.parse(json['date_of_assgined']),
      description: json['description'],
      estimatedTime: Duration(
        hours: int.parse(json['tiempo_estimado'].split(':')[0]),
        minutes: int.parse(json['tiempo_estimado'].split(':')[1]),
        seconds: int.parse(json['tiempo_estimado'].split(':')[2]),
      ),
      timeSelected: json['time_selected'],
      amount: json['amount'],
    );
  }

  // Método para convertir el objeto AssignmentDTO a un JSON
  Map<String, dynamic> toJson() {
    return {
      'name_of_service': nameOfService,
      'date_of_assgined': dateOfAssigned.toIso8601String(),
      'description': description,
      'tiempo_estimado': '${estimatedTime.inHours}:${estimatedTime.inMinutes.remainder(60)}:${estimatedTime.inSeconds.remainder(60)}',
      'time_selected': timeSelected,
      'amount': amount,
    };
  }
}
