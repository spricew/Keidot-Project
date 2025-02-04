import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/transaction/service_transaction_controller.dart';
import 'package:test_app/presentation/screens/transferenciaespera_screen.dart';

class MetodoPagoScreen extends StatelessWidget {
  final ServiceTransactionController controller = Get.find<ServiceTransactionController>();

  final List<Map<String, String>> paymentMethods = [
    {"paymentmethod_id": "299a0de6-a251-42ad-9001-e574d78a28fd", "name_at": "Débito"},
    {"paymentmethod_id": "bb802d71-d245-4881-8503-c4e91d2f1c32", "name_at": "Crédito"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seleccionar Método de Pago")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                final method = paymentMethods[index];
                return Obx(() {
                  return ListTile(
                    title: Text(method["name_at"]!),
                    leading: Icon(Icons.credit_card),
                    trailing: controller.requestData.value.paymentMethodId == method["paymentmethod_id"]
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : null,
                    onTap: () {
                      controller.setPaymentMethod(method["paymentmethod_id"]!);
                    },
                  );
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                if (controller.requestData.value.paymentMethodId.isNotEmpty) {
                  // Navega a la pantalla de Transferencia en Espera
                  Get.to(() => TransferenciaEsperaScreen());
                } else {
                  Get.snackbar("Error", "Selecciona un método de pago");
                }
              },
              child: Text("Confirmar"),
            ),
          ),
        ],
      ),
    );
  }
}