class LocationModel {
  final String? idLocation;
  final String assignmentId;
  final double latitude;
  final double longitude;

  LocationModel({
    this.idLocation,
    required this.assignmentId,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      "assignment_id": assignmentId,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      idLocation: json['id_location'],
      assignmentId: json['assignment_id'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
}
