class ServiceTransactionModel {
  String userId;
  String serviceId;
  String description;
  double amount;
  Duration tiempoEstimado;
  String selectedTime;

  ServiceTransactionModel({
    required this.userId,
    required this.serviceId,
    required this.description,
    required this.amount,
    required this.tiempoEstimado,
    required this.selectedTime,
  });

  // Método para convertir el modelo a JSON
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "serviceId": serviceId,
      "description": description,
      "amount": amount,
      "tiempo_estimado": tiempoEstimado.inHours, // Convertir Duration a horas
      "selected_time": selectedTime, // Formato HH:mm
    };
  }
}