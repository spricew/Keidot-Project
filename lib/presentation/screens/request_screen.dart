import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

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
          // Volver al Home (índice 0)
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              height: 200,
              width: double.infinity,
              child: const Center(
                child: Text(
                  'Detalles del servicio',
                  style: TextStyle(
                    fontSize: 26,
                    color: darkGreen,
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
