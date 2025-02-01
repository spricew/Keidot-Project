import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_appbar.dart';
import 'package:test_app/widgets/custom_input.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              height: 100,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Center(
                    child: CustomInput(
                        labelText: 'Buscar servicio',
                        prefixIcon: Icons.search)),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(137, 226, 155, 155)),
              height: 200,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.only(top: 26, left: 24),
                child: Text(
                  'Ofertas de hoy',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: darkGreen),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(136, 169, 226, 155)),
              height: 200,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.only(top: 26, left: 24),
                child: Text(
                  'Todos los servicios',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: darkGreen),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
