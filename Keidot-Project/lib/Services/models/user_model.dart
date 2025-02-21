class UserModel {
  final String idRol;
  final String email;
  final String username;
  final int phone;
  final String password;
  final String urlImage;

  UserModel({
    this.idRol = "48ca9dac-9978-44e9-a15c-c203793bc9bf", // 👈 Valor fijo
    required this.email,
    required this.username,
    required this.phone,
    required this.password,
    required this.urlImage
  });

  Map<String, dynamic> toJson() {
    return {
      "id_rol": idRol,
      "email": email,
      "username": username,
      "phone": phone,
      "password": password,
      "url_identificacion":urlImage,
    };
  }
}
