import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/home_appbar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: Container(
          width: double.infinity, // Ancho del contenedor
          height: 220, // Altura del contenedor
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 33, 243, 93), // Color de fondo
            borderRadius:
                BorderRadius.all(Radius.circular(20)), // Bordes redondeados
          ),
          child: const Center(
            child: Text(
              'putos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
