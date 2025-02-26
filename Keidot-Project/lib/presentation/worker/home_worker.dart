// home_worker.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/home_screen.dart';
import 'package:test_app/widgets/custom_popup.dart';

class HomeWorker extends StatefulWidget {
  const HomeWorker({super.key});

  @override
  _HomeWorkerState createState() => _HomeWorkerState();
}

class _HomeWorkerState extends State<HomeWorker> {
  bool _isClient = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: const CustomPopupMenu(),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Keidot (Trabajador)',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.8,
              color: greenHigh,
            ),
          ),
        ),
        actions: [
          Switch(
            value: _isClient,
            onChanged: (value) {
              setState(() {
                _isClient = value;
              });
              if (_isClient) {
                // Usa Get.to() para navegar sin eliminar la pantalla anterior
                Get.to(() => const HomeScreen());
              } else {
                // Regresar a HomeWorker si el switch vuelve a false
                Get.to(() => const HomeWorker());
              }
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Pantalla de trabajador',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
