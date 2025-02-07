import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
          crossAxisCount: 2, // Número de columnas
          crossAxisSpacing: 10, // Espaciado horizontal
          mainAxisSpacing: 10, // Espaciado vertical
          padding: EdgeInsets.all(10),
          children: List.generate(6, (index) {
            return Container(
              color: Colors.blueAccent,
              child: Center(child: Text('Item $index', style: TextStyle(color: Colors.white))),
            );
          }),
        ),
    );
  }
}
