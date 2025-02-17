import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/new_worker.dart';
import 'package:test_app/providers/user_provider.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = Provider.of<UserProvider>(context).userName ?? "Usuario";

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
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        decoration: BoxDecoration(
                          color: grayContrast,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.2,
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
                      ElevatedButton(
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
                    ],
                  ),
                ),
              ),
            );
          },
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
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: darkGreen,
                letterSpacing: -0.4,
              ),
            ),
            if (value.isNotEmpty)
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: greenContrast,
                ),
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
