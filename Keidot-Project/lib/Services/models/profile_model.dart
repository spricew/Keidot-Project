class ProfileModel {
  final String? urlImagePerfil;
  final String address;
  final String city;
  final int yearsExperience;
  final String skills;
  final String biography;

  ProfileModel({
    this.urlImagePerfil,
    required this.address,
    required this.city,
    required this.yearsExperience,
    required this.skills,
    required this.biography,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'url_image_perfil': urlImagePerfil,
      'address': address,
      'city':city,
      'experience_years':yearsExperience,
      'skills': skills,
      'biography':biography,
    };
  }
}
/*factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['service_id'] as String,
      title: json['title'] as String,
      urlImage: json['url_image'] as String,
    );
  }*/