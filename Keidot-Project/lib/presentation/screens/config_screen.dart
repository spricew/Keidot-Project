import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              // 🟢 Sección de Perfil
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                  color: grayContrast,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 50, color: darkGreen),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Hola, $name!",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // 🟢 Contenedor con tamaño ajustable para el Grid
              SizedBox(
                height:
                    screenHeight * 0.5, // Ajusta según el tamaño de la pantalla
                child: GridView.builder(
                  physics:
                      const NeverScrollableScrollPhysics(), // Evita scroll dentro del Grid
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.8,
                  ),
                  itemCount: _options.length,
                  itemBuilder: (context, index) {
                    final option = _options[index];
                    return _buildGridItem(
                        option["title"]!, option["value"]!, option["icon"]!);
                  },
                ),
              ),

              const SizedBox(height: 10),

              // 🟢 Botón de Cerrar Sesión con Padding
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Cerrar sesión",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
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
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: darkGreen,
                letterSpacing: -0.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (value.isNotEmpty)
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: greenContrast,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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

// 🟢 Lista de opciones
final List<Map<String, dynamic>> _options = [
  {"title": "Comentarios", "value": "69", "icon": Icons.comment},
  {"title": "Reseñas", "value": "75", "icon": Icons.star},
  {"title": "Cambiar nombre", "value": "", "icon": Icons.person_outline},
  {"title": "Cambiar contraseña", "value": "", "icon": Icons.lock_outline},
  {"title": "Convertirse en trabajador", "value": "", "icon": Icons.work},
  {"title": "Soporte", "value": "", "icon": Icons.support_agent},
];
