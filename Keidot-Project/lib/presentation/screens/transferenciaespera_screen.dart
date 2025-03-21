import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Services/client_request/transaction/service_transaction_controller.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/providers/user_provider.dart';
import 'solicitud_exitosa_screen.dart'; // Asegúrate de importar la pantalla de solicitud exitosa
import 'package:intl/intl.dart';

class TransferenciaEsperaScreen extends StatelessWidget {
  final ServiceTransactionController controller = Get.find();
  TransferenciaEsperaScreen({super.key}); // Obtén el controlador

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<ServiceTransactionController>();
    final name = Provider.of<UserProvider>(context).userName ?? "Usuario";
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
        centerTitle: true,
        title: const Text(
          'Transferencia en Espera',
          style: TextStyle(color: Color(0xFF3BA670)),
        ),
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Pago retenido',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                DateFormat('HH:mm').format(
                    DateTime.now()), // Muestra la hora actual en formato 24h
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                controller.serviceName.value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Transferencia en espera',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Obx(() {
                final amount =
                    transactionController.transaction.value.amount ?? 0.0;
                return Text(
                  '\$${amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              const SizedBox(height: 20),
              const Text(
                'La transferencia se reflejará cuando el trabajo se concluya',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'CUENTA',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 49, 194, 49),
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'SIGN CLARE STP',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Referencia: $reference',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Folio: $folio',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Envía los datos al servidor
                  await controller.sendRequest();
                  //
                  // Navega a la pantalla de solicitud exitosa
                  Get.to(() => const SolicitudExitosaScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12372A), // Color verde
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Confirmar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final String reference = _generateRandomNumber(7);
  final String folio = _generateRandomNumber(9);

  static String _generateRandomNumber(int length) {
    final Random random = Random();
    return List.generate(length, (_) => random.nextInt(10).toString()).join();
  }
}
