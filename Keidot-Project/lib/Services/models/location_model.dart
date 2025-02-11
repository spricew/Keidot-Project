class LocationModel {
  final String userId;
  final double latitude;
  final double longitude;

  LocationModel({
    required this.userId,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
