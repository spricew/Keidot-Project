class UserModel {
  final String idRol;
  final String email;
  final String username;
  final int phone;
  final String password;

  UserModel({
    this.idRol = "ac172fd1-5422-4160-8328-d32464508c48", // 👈 Valor fijo
    required this.email,
    required this.username,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "id_rol": idRol,
      "email": email,
      "username": username,
      "phone": phone,
      "password": password,
    };
  }
}
