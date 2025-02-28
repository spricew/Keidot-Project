class ServiceTransactionModel {
  String userId;
  String serviceId;
  String description;
  double amount;
  String estimatedSize;
  String selectedTime;
  List<String> featureIds; // ✅ NUEVO

  ServiceTransactionModel({
    required this.userId,
    required this.serviceId,
    required this.description,
    required this.amount,
    required this.estimatedSize,
    required this.selectedTime,
    this.featureIds = const [], // ✅ Inicializamos con lista vacía
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "serviceId": serviceId,
      "description": description,
      "amount": amount,
      "estimated_size": estimatedSize,
      "selected_time": selectedTime,
      "featureIds": featureIds, // ✅ Se incluye en la petición
    };
  }
}
