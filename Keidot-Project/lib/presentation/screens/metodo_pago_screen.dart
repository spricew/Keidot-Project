import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/presentation/screens/transferenciaespera_screen.dart';

class MetodoPagoScreen extends StatelessWidget {
  final String serviceName;
  final String serviceId;

  const MetodoPagoScreen({super.key, required this.serviceName, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ingresar tarjeta")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => TransferenciaEsperaScreen(
                    serviceName: serviceName,
                    serviceId: serviceId,
                  ));
            },
            child: const Text("Confirmar"),
          ),
        ),
      ),
    );
  }
}
