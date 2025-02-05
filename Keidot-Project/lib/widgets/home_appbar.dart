import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 35,
      backgroundColor: const Color.fromARGB(77, 203, 0, 0),
      automaticallyImplyLeading: false, // Desactiva el ícono de regresar
      leading: PopupMenuButton(
        // Mueve el menú al lado izquierdo
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: InkWell(
                child: const Text("Modificar"),
                onTap: () {
                  Navigator.pop(context);
                  // ignore: avoid_print
                  print("Estas en Modificar");
                },
              ),
            )
          ];
        },
        icon: const Icon(Icons.menu),
      ),
      title: const Align(
        // Mueve el título hacia la derecha
        alignment: Alignment.centerRight,
        child: Text(
          'Keidot',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.8,
            color: greenHigh,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65); // Altura del AppBar
}
