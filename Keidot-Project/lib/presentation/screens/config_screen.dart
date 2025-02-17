import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/new_worker.dart';
// Importar aquí las pantallas cuando las crees

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Color del navbar
        elevation: 0, // Sin sombra
        leading: Padding(
          padding:
              const EdgeInsets.all(8.0), // Espaciado para que no esté pegado
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle, // Hace el fondo circular
              color: Colors.white, // Fondo blanco
            ),
            child: IconButton(
              icon:
                  const Icon(Icons.arrow_back, color: darkGreen), // Icono negro
              onPressed: () {
                Navigator.pop(context); // Regresa a la pantalla anterior
              },
            ),
          ),
        ),
      ),

      backgroundColor: defaultWhite, // Fondo oscuro
      body: SingleChildScrollView(
        // Hace que todo sea scrolleable
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              // Contenedor de perfil con foto y nombre
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                  color: grayContrast,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min, // Se adapta al contenido
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 50, color: darkGreen),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Heyder Medina",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Grid de opciones
              GridView.count(
                physics:
                    const NeverScrollableScrollPhysics(), // Evita scroll independiente
                shrinkWrap: true, // Se adapta al contenido
                crossAxisCount: 2, // Número de columnas
                crossAxisSpacing: 10, // Espaciado horizontal
                mainAxisSpacing: 10, // Espaciado vertical
                childAspectRatio: 2.2, // Relación de aspecto
                children: [
                  _buildGridItem("Comentarios", "69", Icons.comment),
                  _buildGridItem("Reseñas", "75", Icons.star),
                  _buildGridItem("Cambiar nombre", "", Icons.person_outline),
                  _buildGridItem("Cambiar contraseña", "", Icons.lock_outline),
                  _buildGridItem("Convertirse en trabajador", "", Icons.work),
                  _buildGridItem("Soporte", "", Icons.support_agent),
                ],
              ),

              const SizedBox(height: 20),

              // Botón de cerrar sesión
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {},
                child: const Text("Cerrar sesión",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(String title, String value, IconData icon) {
    return GestureDetector(
      onTap: () {
        switch (title) {
          case "Comentarios":
            // Get.to(() => CommentsScreen()); // Crear y redirigir a CommentsScreen
            break;
          case "Reseñas":
            // Get.to(() => ReviewsScreen()); // Crear y redirigir a ReviewsScreen
            break;
          case "Cambiar nombre":
            // Get.to(() => ChangeNameScreen()); // Crear y redirigir a ChangeNameScreen
            break;
          case "Cambiar contraseña":
            // Get.to(() => ChangePasswordScreen()); // Crear y redirigir a ChangePasswordScreen
            break;
          case "Convertirse en trabajador":
            Get.to(() => const NewWorkerScreen()); // Redirigir a la pantalla de trabajador
            break;
          case "Soporte":
            // Get.to(() => SupportScreen()); // Crear y redirigir a SupportScreen
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: grayContrast,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: darkGreen,
                    letterSpacing: -0.4)),
            if (value.isNotEmpty)
              Text(value,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: greenContrast)),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(icon, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}
