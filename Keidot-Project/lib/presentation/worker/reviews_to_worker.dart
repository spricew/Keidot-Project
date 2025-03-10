import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/config/theme/app_theme.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState(); //Parte del trabajador para que cuando se cambie el status a "Completado "me redirija a esta pantalla
  //donde podra el Cliente opinar sobre el trabajo hecho por el trabajador, subir fotos de la camara del cel
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final TextEditingController commentController = TextEditingController();
  int selectedRating = 0; // Valor inicial: 0 estrellas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          'Reseñas de Trabajos',
          style: TextStyle(
            color: Color(0xFF3BA670),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          const Text(
            'Opinión sobre el trabajo:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: darkGreen),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Muestra el nombre del usuario (valor fijo)
                      const Text('Nombre del Usuario:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('Aqui va el nombre del usuario Diegas'),
                      const SizedBox(height: 12),
                      // Botón para subir imagen, sin funcionalidad
                      const Text('Sube una imagen del trabajo realizado:'),
                      const SizedBox(height: 8),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {}, // Funcionalidad futura
                          icon: const Icon(Icons.upload_file),
                          label: const Text('Seleccionar archivo'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Área para escribir reseña
                      const Text('Escribe tu reseña:'),
                      TextField(
                        controller: commentController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Escribe tu reseña',
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 8),
                      // Estrellas para la calificación, ahora con funcionalidad
                      Row(
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              index < selectedRating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedRating = index + 1;
                              });
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 8),
                      // Botón de enviar con colores invertidos
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {}, // Funcionalidad futura
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.green,
                          ),
                          child: const Text('Enviar Reseña'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
