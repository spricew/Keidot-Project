import 'package:flutter/material.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Configuración',
        backgroundColor: Colors.transparent,
        titleFontSize: 24,
        toolbarHeight: 80,
      ),
      body: _ConfigView(),
    );
  }
}

class _ConfigView extends StatelessWidget {
  final List<Map<String, dynamic>> options = [
    {'title': 'Cambiar nombre', 'icon': Icons.edit},
    {'title': 'Cambiar contraseña', 'icon': Icons.lock},
    {'title': 'Convertirse en trabajador', 'icon': Icons.work},
    {'title': 'Soporte', 'icon': Icons.help},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return _OptionCard(
                    title: options[index]['title'],
                    icon: options[index]['icon'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _OptionCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: colors.outline, width: 0.3),
            color: colors.onPrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: size.height * 0.08,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 22, color: Colors.grey),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: TextStyle(
                      color: colors.onPrimaryContainer,
                      fontSize: size.height * 0.019,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
            ],
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
