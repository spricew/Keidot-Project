import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/config/theme/app_theme.dart';
// Si tienes un provider para el usuario trabajador, lo podrías importar.
// import 'package:provider/provider.dart';
// import 'package:test_app/providers/user_provider.dart';

class WorkerSettingsScreen extends StatelessWidget {
  const WorkerSettingsScreen({super.key});

  // Para este ejemplo usamos un nombre fijo; normalmente se obtendría de un provider.
  final String workerName = "Trabajador";

  final List<Map<String, dynamic>> _workerOptions = const [
    {"title": "Comentarios", "value": "69", "icon": Icons.comment},
    {"title": "Reseñas", "value": "75", "icon": Icons.star},
    {"title": "Cambiar nombre", "value": "", "icon": Icons.person_outline},
    {"title": "Cambiar contraseña", "value": "", "icon": Icons.lock_outline},
    {"title": "Soporte", "value": "", "icon": Icons.support_agent},
  ];

  Widget _buildGridItem(
      String title, String value, IconData icon, double textScale) {
    return GestureDetector(
      onTap: () {
        // Aquí se definen las acciones para cada opción.
        switch (title) {
          case "Comentarios":
            // Acción para Comentarios
            break;
          case "Reseñas":
            // Acción para Reseñas
            break;
          case "Cambiar nombre":
            // Por ejemplo, podrías navegar a una pantalla para cambiar el nombre:
            // Get.to(() => const WorkerChangeNameScreen());
            break;
          case "Cambiar contraseña":
            // Acción para cambiar contraseña
            break;
          case "Soporte":
            // Acción para soporte
            break;
          default:
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: grayContrast,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16 * textScale,
                fontWeight: FontWeight.w500,
                color: darkGreen,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (value.isNotEmpty)
              Text(
                value,
                style: TextStyle(
                  fontSize: 16 * textScale,
                  fontWeight: FontWeight.bold,
                  color: greenContrast,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(icon, size: 22 * textScale),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Si usas Provider para obtener el nombre, descomenta la siguiente línea:
    // final name = Provider.of<UserProvider>(context).userName ?? "Trabajador";
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final textScale = MediaQuery.of(context).textScaleFactor;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: darkGreen),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
        ),
        backgroundColor: defaultWhite,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
            horizontal: screenWidth * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
                decoration: BoxDecoration(
                  color: grayContrast,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.12,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: screenWidth * 0.15,
                        color: darkGreen,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Hola, $workerName!",
                      style: TextStyle(
                        fontSize: 20 * textScale,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth > 600 ? 3 : 2,
                  crossAxisSpacing: screenWidth * 0.02,
                  mainAxisSpacing: screenHeight * 0.02,
                  childAspectRatio: screenWidth > 600 ? 2 : 1.6,
                ),
                itemCount: _workerOptions.length,
                itemBuilder: (context, index) {
                  final option = _workerOptions[index];
                  return _buildGridItem(
                    option["title"] as String,
                    option["value"] as String,
                    option["icon"] as IconData,
                    textScale,
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(double.infinity, screenHeight * 0.06),
                ),
                onPressed: () {
                  // Acción de cerrar sesión, por ejemplo:
                  // Get.offAll(() => const LoginScreen());
                },
                child: Text(
                  "Cerrar sesión",
                  style: TextStyle(fontSize: 16 * textScale, color: Colors.white),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
