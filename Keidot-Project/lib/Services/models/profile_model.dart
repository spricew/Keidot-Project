class Profile {
  final String userId;
  final String? fullname;
  final String? urlImagePerfil;
  final String? address;
  final String? city;
  final int? experienceYears;
  final String? bio;
  final double? rating;

  Profile({
    required this.userId,
    this.fullname,
    this.urlImagePerfil,
    this.address,
    this.city,
    this.experienceYears,
    this.bio,
    this.rating,
  });

  // Convertir de JSON a Profile
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userId: json['user_id'] as String,
      fullname: json['fullname'] as String?,
      urlImagePerfil: json['url_image_perfil'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      experienceYears: json['experience_years'] as int?,
      bio: json['bio'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  // Convertir de Profile a JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'fullname': fullname,
      'url_image_perfil': urlImagePerfil,
      'address': address,
      'city': city,
      'experience_years': experienceYears,
      'bio': bio,
      'rating': rating,
    };
  }
}
