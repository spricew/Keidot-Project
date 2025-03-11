class ReviewModel {
  int rating;
  String urlImagen;
  String commentAt;

  ReviewModel({
    this.rating = 1, // Valor por defecto
    this.urlImagen = "ambientedeprueba.com", // Valor por defecto
    required this.commentAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "rating": rating > 0 ? rating : 1, // Si rating es 0, usa 1
      "url_imagen": urlImagen.isNotEmpty ? urlImagen : "ambientedeprueba.com", // Si está vacío, usa el valor por defecto
      "comment_at": commentAt,
    };
  }
}
