import 'package:flutter/material.dart';
import 'package:test_app/presentation/screens/request_screen2.dart';

class RequestDetailsGarden extends StatefulWidget {
  const RequestDetailsGarden({super.key});

  @override
  _RequestDetailsGardenState createState() => _RequestDetailsGardenState();
}

class _RequestDetailsGardenState extends State<RequestDetailsGarden> {
  // Opciones disponibles para describir el jardín
  final List<Map<String, dynamic>> gardenOptions = [
    {'label': 'Tiene piscina', 'selected': false},
    {'label': 'Tiene decoraciones', 'selected': false},
    {'label': 'Tiene árboles grandes', 'selected': false},
    {'label': 'Tiene césped artificial', 'selected': false},
    {'label': 'Tiene caminos de piedra', 'selected': false},
    {'label': 'Tiene macetas grandes', 'selected': false},
    {'label': 'Tiene sistema de riego', 'selected': false},
    {'label': 'Es un jardín con desniveles', 'selected': false},
  ];

  List<String> images = []; // Simulación de imágenes agregadas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Detalles del jardín',
          style: TextStyle(color: Color(0xFF3BA670), fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Selecciona los aspectos de tu jardín',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),

            // Lista de opciones seleccionables
            Expanded(
              child: ListView(
                children: gardenOptions.map((option) {
                  return CheckboxListTile(
                    title: Text(option['label']),
                    value: option['selected'],
                    onChanged: (bool? value) {
                      setState(() {
                        option['selected'] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Adjuntar fotos del jardín',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (var img in images)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300], // Espacio para imágenes
                    ),
                  ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add_a_photo,
                        size: 30, color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child:
                      const Text('Atrás', style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequestScreen2()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12372A),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: const Text('Siguiente',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
