class Service {
  final String? serviceId;
  final String title;
  final String urlImage;

  Service({
    this.serviceId,
    required this.title,
    required this.urlImage,
  });

  // Método para convertir un JSON en un objeto Service
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['service_id'] as String,
      title: json['title'] as String,
      urlImage: json['url_image'] as String,
    );
  }

  // Método para convertir un objeto Service a JSON (si lo necesitas)
  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'title': title,
      'url_image': urlImage,
    };
  }
}
