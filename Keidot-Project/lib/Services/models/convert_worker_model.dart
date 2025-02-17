class UserProfile {
  final String urlImagePerfil;
  final String address;
  final String city;
  final int experienceYears;
  final String biography;

  UserProfile({
    required this.urlImagePerfil,
    required this.address,
    required this.city,
    required this.experienceYears,
    required this.biography,
  });

  // Método para convertir un JSON en un objeto UserProfile
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      urlImagePerfil: json['url_image_perfil'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      experienceYears: json['experience_years'] as int,
      biography: json['biography'] as String,
    );
  }

  // Método para convertir un objeto UserProfile a JSON
  Map<String, dynamic> toJson() {
    return {
      'url_image_perfil': urlImagePerfil,
      'address': address,
      'city': city,
      'experience_years': experienceYears,
      'biography': biography,
    };
  }
}
