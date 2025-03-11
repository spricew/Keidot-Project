import 'package:flutter/cupertino.dart';
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
    return SafeArea(
      child: Center(
        child: Wrap(
          spacing: 8.0, // Espaciado horizontal entre elementos
          runSpacing: 8.0, // Espaciado vertical entre líneas
          children: [
            _CardBuilder(
              title: 'Reseñas',
              score: 4.0,
              textSize: sizeW * 0.04,
              icon: Icons.star,
            ),
            _CardBuilder(
              title: 'Cancelaciones',
              score: 12,
              icon: Icons.percent,
              textSize: sizeW * 0.04,
            ),
            _CardBuilder(
              title: 'Servicios semanales',
              score: 502,
              textSize: sizeW * 0.035,
              icon: Icons.add,
            ),
            _CardBuilder(
              title: 'Ganancias semanales',
              score: 10522.25,
              textSize: sizeW * 0.035,
              icon: Icons.arrow_upward,
            ),
          ],
        ),
      ),
    );
  }
}

class _CardBuilder extends StatelessWidget {
  final String title;
  final double score;
  final IconData icon;
  final double textSize;

  const _CardBuilder({
    required this.title,
    required this.score,
    required this.icon,
    this.textSize = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    final sizeH = MediaQuery.of(context).size.height;
    final colors = Theme.of(context).colorScheme;
    String formatNumber(double number) {
      if (number >= 1000) {
        return '${(number / 1000).toStringAsFixed(1)}K';
      }
      return number.toString();
    }

    return Container(
      decoration: BoxDecoration(
          color: colors.onPrimary,
          borderRadius: BorderRadius.circular(sizeH * 0.016),
          border: Border.all(color: Colors.black26, width: 1.0)),
      width: sizeW * 0.45,
      height: sizeH * 0.16,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: textSize, letterSpacing: -0.3, height: 0.98),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  formatNumber(score),
                  style: TextStyle(
                      fontSize: sizeW * 0.08, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 4),
                Icon(
                  icon,
                  color: greenHigh,
                  size: sizeW * 0.065,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
