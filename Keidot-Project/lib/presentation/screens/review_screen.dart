import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_app/Services/client_request/review_request/review_controller.dart';
import 'package:test_app/presentation/screens/home_page.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Describe tu experiencia'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: _ViewReview(),
    );
  }
}

class _ViewReview extends StatefulWidget {
  @override
  __ViewReviewState createState() => __ViewReviewState();
}

class __ViewReviewState extends State<_ViewReview> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final ReviewController reviewController = Get.put(ReviewController());
  final TextEditingController commentController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? selectedImage = await _picker.pickImage(source: source);
    setState(() {
      _image = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Cuéntanos cómo fue tu servicio',
                style: TextStyle(fontSize: 21, letterSpacing: -0.6),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Comentarios',
                ),
                maxLines: 5,
                onChanged: (value) => reviewController.setCommentAt(value),
              ),
              const SizedBox(height: 40),
              const Text(
                'Adjunta evidencias',
                style: TextStyle(fontSize: 21, letterSpacing: -0.6),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.add_a_photo),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Wrap(
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Galería'),
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_camera),
                              title: const Text('Cámara'),
                              onTap: () {
                                _pickImage(ImageSource.camera);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                label: const Text('Agregar foto'),
              ),
              const SizedBox(height: 10),
              Obx(
                () => reviewController.urlImagen.isNotEmpty
                    ? Image.file(
                        File(reviewController.urlImagen.value),
                        width: MediaQuery.of(context).size.width * 0.45,
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                ),
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: () async {
                  reviewController.commentAt(commentController.text);
                  bool success = await reviewController.sendReview();
                  if (success) {
                    Get.defaultDialog(
                      titlePadding: const EdgeInsets.all(20),
                      contentPadding:
                          const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      title: '¡Gracias por tu opinión!',
                      middleText: 'Tu opinión es muy importante para nosotros.',
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const Homepage();
                            }));
                          },
                          child: const Text('Regresar al inicio'),
                        ),
                      ],
                    );
                  } else {
                    Get.snackbar(
                      'Error',
                      'No se pudo enviar la reseña.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                label: const Text(
                  'Enviar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
