import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/client_request/garden_feature_request/garden_request.dart';
import 'package:test_app/Services/models/garden_feature_model.dart';
import 'package:test_app/Services/client_request/transaction/service_transaction_controller.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/request_screen2.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class RequestDetailsGarden extends StatefulWidget {
  const RequestDetailsGarden({super.key});

  @override
  _RequestDetailsGardenState createState() => _RequestDetailsGardenState();
}

class _RequestDetailsGardenState extends State<RequestDetailsGarden> {
  final GardenFeatureService _gardenFeatureService = GardenFeatureService();
  final ServiceTransactionController _controller =
      Get.find<ServiceTransactionController>();

  List<Map<String, dynamic>> gardenOptions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGardenFeatures();
  }

  Future<void> _loadGardenFeatures() async {
    try {
      final List<GardenFeature> features =
          await _gardenFeatureService.fetchFeatures();
      setState(() {
        gardenOptions = features
            .map((feature) => {
                  'id': feature.id,
                  'label': feature.name,
                  'selected': _controller.transaction.value.featureIds
                      .contains(feature.id),
                })
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  void _saveSelectedFeatures() {
    List<String> selectedFeatureIds = gardenOptions
        .where((feature) => feature['selected'] == true)
        .map((feature) => feature['id'] as String)
        .toList();

    if (selectedFeatureIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona al menos una característica')),
      );
      return;
    }

    // Guardamos en el controlador antes de avanzar a la siguiente pantalla
    _controller.setFeatureIds(selectedFeatureIds);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RequestScreen2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Detalles del jardín',
        toolbarHeight: 65,
        titleFontSize: 25,
        backgroundColor: defaultWhite,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Selecciona los aspectos de tu jardín',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      children: gardenOptions.map((option) {
                        return CheckboxListTile(
                          title: Text(option['label']),
                          value: option['selected'],
                          onChanged: (bool? value) {
                            setState(() => option['selected'] = value!);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Atrás',
                            style: TextStyle(color: Colors.red)),
                      ),
                      ElevatedButton(
                        onPressed: _saveSelectedFeatures,
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
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }
}
