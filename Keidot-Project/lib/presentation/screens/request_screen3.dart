import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/transaction/service_transaction_controller.dart';
import 'metodo_pago_screen.dart'; // Importa la pantalla de Método de Pago

class RequestScreen3 extends StatefulWidget {
  final String serviceName;
  const RequestScreen3({super.key,required this.serviceName});

  @override
  _RequestScreen3State createState() => _RequestScreen3State();
}

class _RequestScreen3State extends State<RequestScreen3> {
  final ServiceTransactionController controller =
      Get.find(); // Obtén el controlador
  String? _selectedDate; // Para almacenar la fecha seleccionada
  final TextEditingController _descriptionController =
      TextEditingController(); // Controlador para el campo de descripción

  // Método para mostrar el selector de fecha y hora con validaciones
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 8, minute: 0),
      );

      if (pickedTime != null) {
        // Validar que la hora esté en el rango permitido (08:00 - 18:00)
        if (pickedTime.hour < 8 || pickedTime.hour > 18) {
          Get.snackbar("Error", "Selecciona un horario entre 08:00 y 18:00");
          return;
        }

        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _selectedDate = "${selectedDateTime.toLocal()}"
              .split(' ')[0]; // Guarda la fecha seleccionada
        });

        // Guarda la hora en el formato correcto (HH:mm)
        final formattedTime =
            "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
        controller.setSelectedTime(formattedTime);
      }
    }
  }

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
            const Center(
              child: Text(
                'Paso 2 de 3',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3BA670),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Selección de fecha
            const Text(
              'Fecha',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0, // Espacio entre los botones
              children: [
                _buildDateOption('Definir fecha'),
              ],
            ),
            const SizedBox(height: 20),

            // Campo de descripción
            const Text(
              'Descripción',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 3, // Permite múltiples líneas
              decoration: InputDecoration(
                hintText: 'Escribe una descripción...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                controller.setDescription(
                    value); // Guarda la descripción en el controlador
              },
            ),
            const Spacer(),

            // Botones Anterior y Siguiente
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Regresa a la pantalla anterior
                  },
                  child: const Text(
                    'Anterior',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Valida que se haya seleccionado una fecha y hora
                    if (controller.selectedTime.value.isEmpty) {
                      Get.snackbar("Error", "Selecciona una fecha y hora");
                      return;
                    }

                    // Navega a la siguiente pantalla
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MetodoPagoScreen(
                          serviceName: widget.serviceName,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12372A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
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

        // Guarda la fecha seleccionada en el controlador
        if (selected) {
          _selectDateTime(context); // Abre el selector de fecha y hora
        }
      },
      selectedColor:
          const Color(0xFF12372A), // Color verde cuando está seleccionado
      labelStyle: TextStyle(
        color: _selectedDate == date ? Colors.white : Colors.black,
      ),
    );
  }
}
