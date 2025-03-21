class ProfileWorkerDTO {
  final String fullname;
  final int experienceYears;
  final String email;
  final int phone;
  final String bio;

  ProfileWorkerDTO({
    required this.fullname,
    required this.experienceYears,
    required this.email,
    required this.phone,
    required this.bio,
  });

  factory ProfileWorkerDTO.fromJson(Map<String, dynamic> json) {
    return ProfileWorkerDTO(
      fullname: json['fullname'] ?? '',
      experienceYears: json['experience_years'] ?? 0,
      email: json['email'] ?? '',
      phone: json['phone'] ?? 0,
      bio: json['bio'] ?? '',
    );
  }
}