import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_app/Services/location_request/location_service_controller.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/home_page.dart';
import 'package:test_app/widgets/custom_appbar.dart';
import 'package:test_app/widgets/custom_input.dart';
import 'request_screen3.dart';

class RequestScreen2 extends StatefulWidget {
  const RequestScreen2({super.key});

  @override
  _RequestScreen2State createState() => _RequestScreen2State();
}

class _RequestScreen2State extends State<RequestScreen2> {
  final MapController _mapController = MapController();
  static const LatLng initialLocation =
      LatLng(20.9671, -89.6237); // Coordenadas de Mérida
  final LocationController locationController = Get.find<LocationController>();

  LatLng selectedLocation =
      const LatLng(20.9671, -89.6237); // Ubicación inicial

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Ubicación',
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          // 🟢 Mapa en el fondo, ocupando toda la pantalla
          Positioned.fill(
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
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: selectedLocation,
                      width: 80,
                      height: 80,
                      child: Column(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.red, size: 46),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 🟢 Input flotante (posicionado arriba del mapa)
          Positioned(
            top: 20, // Ajusta la posición verticalmente
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: defaultWhite,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CustomInput(
                labelText: 'Buscar ubicación',
                prefixIcon: Icons.search,
                errorText: null,
              ),
            ),
          ),

          // 🟢 Botones en la parte inferior
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      // Navega a la nueva pantalla
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage()),
                      );
                    },
                    child: Text('Cancelar', style: TextStyle(color: redError))),
                const SizedBox(width: 14),
                ElevatedButton(
                  onPressed: () {
                    locationController.setLocation(
                        selectedLocation.latitude, selectedLocation.longitude);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RequestScreen3(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF12372A),
                  ),
                  child: const Text('Elegir ubicación',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
