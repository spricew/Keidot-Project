class ServiceTransactionModel {
  String userId;
  String serviceId;
  String description;
  double amount;
  String estimatedSize;
  String selectedTime;
  List<String> featureIds;
  double latitude;
  double longitude;
  String paymentIntentId;

  ServiceTransactionModel({
    required this.userId,
    required this.serviceId,
    required this.description,
    required this.amount,
    required this.estimatedSize,
    required this.selectedTime,
    this.featureIds = const [],
    required this.latitude,
    required this.longitude,
    required this.paymentIntentId
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "serviceId": serviceId,
      "description": description,
      "amount": amount,
      "estimated_size": estimatedSize,
      "selected_time": selectedTime,
      "featureIds": featureIds,
      "latitude": latitude,
      "longitude": longitude,
      "payment_intent_id": paymentIntentId
    };
  }

  factory ServiceTransactionModel.fromJson(Map<String, dynamic> json) {
    return ServiceTransactionModel(
      userId: json["userId"],
      serviceId: json["serviceId"],
      description: json["description"],
      amount: (json["amount"] as num).toDouble(),
      estimatedSize: json["estimated_size"],
      selectedTime: json["selected_time"],
      featureIds: List<String>.from(json["featureIds"] ?? []),
      latitude: (json["latitude"] as num).toDouble(),
      longitude: (json["longitude"] as num).toDouble(),
      paymentIntentId: json["payment_intent_id"],
    );
  }
}
