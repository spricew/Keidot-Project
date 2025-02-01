import 'package:flutter/material.dart';
import 'package:test_app/presentation/screens/transferenciaespera_screen.dart';
import 'añadir_metodo_pago_screen.dart'; // Asegúrate de importar la pantalla de añadir método de pago

class MetodoPagoScreen extends StatefulWidget {
  @override
  _MetodoPagoScreenState createState() => _MetodoPagoScreenState();
}

class _MetodoPagoScreenState extends State<MetodoPagoScreen> {
  String? _selectedPaymentMethod; // Variable para almacenar la opción seleccionada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
        centerTitle: true,
        title: Text(
          'Jardinería',
          style: TextStyle(color: Color(0xFF3BA670)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Indicador de progreso
            Center(
              child: Text(
                'Paso 3 de 3',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3BA670),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Métodos de pago
            Text(
              'Método de pago',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildPaymentMethod('Tarjeta Visa / MASTERCARD *** 3896'),
            _buildPaymentMethod('Cuenta AKALA *** 8532'),
            SizedBox(height: 10),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnadirMetodoPagoScreen(), // Navega a la pantalla de Añadir Método de Pago
                  ),
                );
              },
              icon: Icon(Icons.add, color: Color(0xFF3BA670)),
              label: Text(
                'Añadir nuevo método de pago',
                style: TextStyle(color: Color(0xFF3BA670)),
              ),
            ),
            Spacer(),

            // Botones Anterior y Siguiente
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Regresa a la pantalla anterior
                  },
                  child: Text(
                    'Anterior',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  onPressed: _selectedPaymentMethod == null
                      ? null // Deshabilita el botón si no hay selección
                      : () {
                          // Navega a la pantalla de Añadir Método de Pago
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransferenciaEsperaScreen(),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF12372A), // Color verde
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Confirmar',
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

  // Método para construir un método de pago
  Widget _buildPaymentMethod(String method) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(Icons.credit_card, color: Color(0xFF3BA670)),
        title: Text(method),
        trailing: _selectedPaymentMethod == method
            ? Icon(Icons.check_circle, color: Color(0xFF3BA670)) // Muestra un ícono de selección
            : null,
        onTap: () {
          setState(() {
            _selectedPaymentMethod = method; // Actualiza la selección
          });
        },
      ),
    );
  }
}