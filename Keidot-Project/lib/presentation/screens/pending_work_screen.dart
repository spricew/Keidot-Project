import 'package:flutter/material.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class PendingWorkScreen extends StatelessWidget {
  const PendingWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Trabajos aceptados',
        backgroundColor: colors.onPrimary,
      ),
      body: _PendingView(),
    );
  }
}

class _PendingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Column(
          children: [
            _CardBuilder(),
            _CardBuilder(),
            _CardBuilder(),
          ],
        ),
      ),
    );
  }
}

class _CardBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.work, size: 30, color: colors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre del servicio',
                    style: TextStyle(
                        color: colors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Fecha: ${DateTime.now()}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Hora: ${DateTime.now()}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'MXN \$${100}',
                    style: TextStyle(color: colors.primary, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
