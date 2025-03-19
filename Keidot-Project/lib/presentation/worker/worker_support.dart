import 'package:flutter/material.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class WorkerSupportPage extends StatelessWidget {
  const WorkerSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Soporte al Cliente',
        backgroundColor: Colors.transparent,
        titleFontSize: 24,
        toolbarHeight: 80,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Soporte al Cliente',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colors.primary, // Color personalizado para el título
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Para cualquier consulta o problema, por favor contacta a nuestro equipo de soporte:',
              style: TextStyle(fontSize: 16, color: colors.onSurface),
            ),
            const SizedBox(height: 8),
            _SupportInfoCard(
              title: 'Email: soporte@keidot.com',
              icon: Icons.email,
              colors: colors,
              size: size,
            ),
            _SupportInfoCard(
              title: 'Teléfono: +52 9993629690',
              icon: Icons.phone,
              colors: colors,
              size: size,
            ),
            const SizedBox(height: 24),
            Text(
              'Sobre Keidot',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colors.primary, // Color personalizado para el título
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Keidot es una aplicación innovadora que ofrece soluciones eficientes para la gestión de tareas y proyectos. Nuestro objetivo es facilitar la organización y mejorar la productividad de nuestros usuarios.',
              style: TextStyle(fontSize: 16, color: colors.onSurface),
            ),
          ],
        ),
      ),
      backgroundColor: colors.surface, // Color de fondo personalizado
    );
  }
}

class _SupportInfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final ColorScheme colors;
  final Size size;

  const _SupportInfoCard({
    required this.title,
    required this.icon,
    required this.colors,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors.outline, width: 0.3),
        color: colors.onPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
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
    );
  }
}