import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Panel de ingresos',
        titleFontSize: 25,
        backgroundColor: colors.onPrimary,
      ),
      body: _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    final sizeH = MediaQuery.of(context).size.height;
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      child: Center(
        child: Wrap(
          spacing: 8.0, // Espaciado horizontal entre elementos
          runSpacing: 8.0, // Espaciado vertical entre líneas
          children: [
            Container(
              decoration: BoxDecoration(
                  color: colors.onPrimary,
                  borderRadius: BorderRadius.circular(sizeH * 0.012),
                  border: Border.all(color: Colors.black26, width: 1.0)),
              width: sizeW * 0.45,
              height: sizeH * 0.15,
            ),
          ],
        ),
      ),
    );
  }
}
