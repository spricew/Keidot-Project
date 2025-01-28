import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Padding alrededor del menú
          child: PopupMenuButton(
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
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16.0), // Padding horizontal al título
          child: Text('Keidot'),
        ),
      ),
      body: const Center(
        child: Text('Página principal'),
      ),
    );
  }
}
