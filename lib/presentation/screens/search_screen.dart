import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class SearchScreen extends StatelessWidget {
  final Function(int) onTabSelected; // Recibe la función para cambiar de índice

  const SearchScreen({super.key, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Búsqueda',
        titleFontSize: 28,
        toolbarHeight: 85,
        backgroundColor: Colors.white,
        titleColor: darkGreen,
        iconColor: darkGreen,
        onBackPressed: () {
          onTabSelected(0); // Volver al Home (índice 0)
        },
      ),
    );
  }
}
