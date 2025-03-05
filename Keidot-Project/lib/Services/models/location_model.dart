class LocationModel {
  final String? idLocation;
  final String userId;
  final double latitude;
  final double longitude;

  LocationModel({
    this.idLocation,
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

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      idLocation: json['idLocation'],
      userId: json['userId'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
}
