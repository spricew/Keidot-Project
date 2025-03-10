import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  const MapScreen({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubicación")),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(latitude, longitude), // ✅ Corregido
          initialZoom: 15.0, // ✅ Corregido
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(latitude, longitude),
                child: const Icon(Icons.location_pin, color: Colors.red, size: 40), // ✅ Corregido
              ),
            ],
          ),
        ],
      ),
    );
  }
}
