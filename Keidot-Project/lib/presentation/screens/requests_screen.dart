import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Solicitudes',
        backgroundColor: Colors.white, // Ajustado al fondo oscuro de la imagen
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: ListView(
          children: List.generate(4, (index) => _buildRequestCard()),
        ),
      ),
    );
  }

  Widget _buildRequestCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1),

        color: grayContrast, // Fondo oscuro como en la imagen
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.work, size: 30, color: darkGreen),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Calle 54 x 67 y 69',
                  style: TextStyle(
                      color: darkGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Jan 10 • 2:46 PM',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  'MXN \$38.56',
                  style: TextStyle(color: greenContrast, fontSize: 14),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.cancel, color: Colors.red, size: 18),
            label: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
