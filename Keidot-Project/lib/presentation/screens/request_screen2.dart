import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_app/Services/location_request/location_service_controller.dart';
import 'request_screen3.dart';

class RequestScreen2 extends StatefulWidget {
  const RequestScreen2({super.key, required String serviceId, required String serviceName});

  @override
  _RequestScreen2State createState() => _RequestScreen2State();
}

class _RequestScreen2State extends State<RequestScreen2> {
  final MapController _mapController = MapController();
  const LatLng initialLocation = LatLng(20.9671, -89.6237); // Coordenadas de Mérida
  final LocationController locationController = Get.find<LocationController>();

  LatLng selectedLocation = const LatLng(20.9671, -89.6237); // Ubicación inicial

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Jardinería',
          style: TextStyle(color: Color(0xFF3BA670)),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar ubicación cercana',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Mapa de OpenStreetMap
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: initialLocation,
                initialZoom: 13,
                onTap: (tapPosition, point) {
                  setState(() {
                    selectedLocation = point;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: selectedLocation,
                      width: 80,
                      height: 80,
                      child: const Icon(Icons.location_on, color: Colors.red, size: 40),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Guardar la ubicación en el controlador
                    locationController.setLocation(selectedLocation.latitude, selectedLocation.longitude);

                    // Ir a la siguiente pantalla
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RequestScreen3(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12372A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Elegir ubicación', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
