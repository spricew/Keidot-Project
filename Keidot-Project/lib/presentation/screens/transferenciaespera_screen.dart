import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/location_request/location_service_controller.dart';
import 'package:test_app/Services/transaction/service_transaction_controller.dart';
import 'solicitud_exitosa_screen.dart'; // Asegúrate de importar la pantalla de solicitud exitosa
import 'package:intl/intl.dart';


class TransferenciaEsperaScreen extends StatelessWidget {
  final ServiceTransactionController controller = Get.find();
  final LocationController controller_location = Get.find();
  final String serviceName; // Recibe el nombre del servicio seleccionado

  TransferenciaEsperaScreen({super.key, required this.serviceName, required String serviceId}); // Obtén el controlador

  @override
  Widget build(BuildContext context) {
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
                'Pago bloqueado',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
                Text(
                  DateFormat('HH:mm').format(DateTime.now()), // Muestra la hora actual en formato 24h
                  style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                ),
              const SizedBox(height: 20),
              Text(
                serviceName,
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
              const Text(
                '\$750',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
              const Text(
                'Kevin Montero',
                style: TextStyle(
                  fontSize: 18,
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
              const Text(
                'Referencia: 4345343',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Foto: 594249572',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Envía los datos al servidor
                  await controller.sendRequest();
                  await controller_location.saveLocation();

                  // Navega a la pantalla de solicitud exitosa
                  Get.to(() =>const SolicitudExitosaScreen());
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
}
