import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importa esto para usar TextInputFormatter
import 'package:test_app/presentation/screens/transferenciaespera_screen.dart'; //Esto lo hizo luis

class AnadirMetodoPagoScreen extends StatelessWidget {
  final String serviceName;
  final String serviceId;
  const AnadirMetodoPagoScreen({super.key, required this.serviceName, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Añadir método de pago',
          style: TextStyle(color: Color(0xFF3BA670)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de correo electrónico
            const Text(
              'Correo electrónico',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'example@example.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Campo de número de tarjeta (un solo campo)
            const Text(
              'Número de tarjeta',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: '1234 5678 9012 3456',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 19, // 16 dígitos + 3 espacios
              inputFormatters: [
                // Formateador para agregar espacios cada 4 dígitos
                FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
                CardNumberInputFormatter(), // Formateador personalizado
              ],
            ),
            const SizedBox(height: 20),

            // Campo de fecha de vencimiento
            const Text(
              'Fecha de vencimiento',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'MM/AA',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              maxLength: 5,
              keyboardType: TextInputType.datetime,
              inputFormatters: [
                // Formateador para agregar la barra (/) automáticamente
                FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                CardExpiryInputFormatter(), // Formateador personalizado
              ],
            ),
            const SizedBox(height: 20),

            // Campo de código de seguridad
            const Text(
              'Código de seguridad',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'CVC',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              maxLength: 3,
              keyboardType: TextInputType.number,
            ),
            const Spacer(),

            // Botones Regresar y Contribuir
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Regresa a la pantalla anterior
                  },
                  child: const Text(
                    'Regresar',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navega a la nueva pantalla
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransferenciaEsperaScreen(
                                serviceName: serviceName,
                                serviceId: serviceId,
                              )),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12372A), // Color verde
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Formateador personalizado para el número de tarjeta
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    // Elimina todos los espacios existentes
    text = text.replaceAll(' ', '');

    // Agrega un espacio cada 4 dígitos
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i != text.length - 1) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

// Formateador personalizado para la fecha de vencimiento
class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    // Elimina la barra (/) si ya existe
    text = text.replaceAll('/', '');

    // Agrega la barra (/) después de los primeros 2 dígitos
    if (text.length >= 2) {
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
