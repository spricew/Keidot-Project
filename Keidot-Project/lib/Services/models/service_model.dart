class Service {
  final String? serviceId;
  final String title;
  final String urlImage;
  final double price;
  final bool isActive;

  Service({
    this.serviceId,
    required this.title,
    required this.urlImage,
    required this.price,
    required this.isActive,
  });

  // Método para convertir un JSON en un objeto Service
  factory Service.fromJson(Map<String, dynamic> json) {
  return Service(
    serviceId: json['service_id'] as String?,
    title: json['title'] as String,
    urlImage: json['url_image'] as String,
    price: (json['price'] as num).toDouble(),  //FIX AQUÍ 
     isActive: json['is_active']
  );
}


  // Método para convertir un objeto Service a JSON (si lo necesitas)
  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'title': title,
      'url_image': urlImage,
      'price': price,
      'is_active': isActive,
    };
  }
}
