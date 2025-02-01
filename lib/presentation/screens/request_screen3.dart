import 'package:flutter/material.dart';
import 'metodo_pago_screen.dart'; // Importa la pantalla de Método de Pago

class RequestScreen3 extends StatefulWidget {
  @override
  _RequestScreen3State createState() => _RequestScreen3State();
}

class _RequestScreen3State extends State<RequestScreen3> {
  String? _selectedDate; // Para almacenar la fecha seleccionada
  final TextEditingController _descriptionController = TextEditingController(); // Controlador para el campo de descripción

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
                'Paso 2 de 3',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3BA670),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Selección de fecha
            Text(
              'Fecha',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0, // Espacio entre los botones
              children: [
                _buildDateOption('Hoy'),
                _buildDateOption('Mañana'),
                _buildDateOption('En 3 días'),
                _buildDateOption('Definir fecha'),
              ],
            ),
            SizedBox(height: 20),

            // Campo de descripción
            Text(
              'Descripción',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 3, // Permite múltiples líneas
              decoration: InputDecoration(
                hintText: 'Escribe una descripción...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
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
                  onPressed: () {
                    // Navega a la pantalla de Método de Pago
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MetodoPagoScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF12372A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Siguiente',
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

  // Método para construir las opciones de fecha
  Widget _buildDateOption(String date) {
    return ChoiceChip(
      label: Text(date),
      selected: _selectedDate == date,
      onSelected: (selected) {
        setState(() {
          _selectedDate = selected ? date : null;
        });
      },
      selectedColor: Color(0xFF12372A), // Color verde cuando está seleccionado
      labelStyle: TextStyle(
        color: _selectedDate == date ? Colors.white : Colors.black,
      ),
    );
  }
}