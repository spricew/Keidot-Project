import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';

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
              icon: const Icon(Icons.arrow_back,
                  color: Colors.black), // Icono negro
              onPressed: () {
                Navigator.pop(context); // Regresa a la pantalla anterior
              },
            ),
          ),
        ),
      ),

      backgroundColor: const Color.fromARGB(221, 123, 123, 123), // Fondo oscuro
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
                  color: lightgreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min, // Se adapta al contenido
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child:
                          Icon(Icons.person, size: 50, color: Colors.black87),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Heyder Medina",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
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
                  _buildGridItem(
                      "Convertirse en trabajador", "", Icons.workspace_premium),
                  _buildGridItem("Soporte", "", Icons.support_agent),
                ],
              ),

              const SizedBox(height: 20),

              // Botón de cerrar sesión
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
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
    return Container(
      decoration: BoxDecoration(
        color: lightgreen,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          if (value.isNotEmpty)
            Text(value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(icon, size: 20),
          ),
        ],
      ),
    );
  }
}
