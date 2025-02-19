import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Services/login_request/auth_serviceController.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/change_name.dart';
import 'package:test_app/presentation/screens/new_worker.dart';
import 'package:test_app/providers/user_provider.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = Provider.of<UserProvider>(context).userName ?? "Usuario";
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
                  Navigator.pop(context);
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
              // 🟢 Sección de Perfil
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
                      "Hola, $name!",
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

              // 🟢 Contenedor del Grid con altura dinámica
              GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Evita doble scroll
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth > 600
                      ? 3
                      : 2, // Más columnas en pantallas grandes
                  crossAxisSpacing: screenWidth * 0.02,
                  mainAxisSpacing: screenHeight * 0.02,
                  childAspectRatio: screenWidth > 600 ? 2 : 1.6,
                ),
                itemCount: _options.length,
                itemBuilder: (context, index) {
                  final option = _options[index];
                  return _buildGridItem(
                    option["title"]!,
                    option["value"]!,
                    option["icon"]!,
                    textScale,
                  );
                },
              ),

              SizedBox(height: screenHeight * 0.02),

              // 🟢 Botón de Cerrar Sesión
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(double.infinity, screenHeight * 0.06),
                ),
                onPressed: () async {
                  await AuthService().logout(
                      context); // Llama al método logout para cerrar sesión
                },
                child: Text(
                  "Cerrar sesión",
                  style:
                      TextStyle(fontSize: 16 * textScale, color: Colors.white),
                ),
              ),

              SizedBox(height: screenHeight * 0.02), // Espacio final
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(
      String title, String value, IconData icon, double textScale) {
    return GestureDetector(
      onTap: () {
        switch (title) {
          case "Comentarios":
            break;
          case "Reseñas":
            break;
          case "Cambiar nombre":
            Get.to(() => const ChangeNameScreen());
            break;
          case "Cambiar contraseña":
            break;
          case "Convertirse en trabajador":
            Get.to(() => const NewWorkerScreen());
            break;
          case "Soporte":
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
}

// 🟢 Lista de opciones
final List<Map<String, dynamic>> _options = [
  {"title": "Comentarios", "value": "69", "icon": Icons.comment},
  {"title": "Reseñas", "value": "75", "icon": Icons.star},
  {"title": "Cambiar nombre", "value": "", "icon": Icons.person_outline},
  {"title": "Cambiar contraseña", "value": "", "icon": Icons.lock_outline},
  {"title": "Convertirse en trabajador", "value": "", "icon": Icons.work},
  {"title": "Soporte", "value": "", "icon": Icons.support_agent},
];
