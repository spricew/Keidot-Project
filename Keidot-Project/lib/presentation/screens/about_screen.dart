import 'package:flutter/material.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Acerca de',
        toolbarHeight: 75,
        backgroundColor: colors.onPrimary,
        titleFontSize: 24,
      ),
      body: const _AboutView(),
    );
  }
}

class _AboutView extends StatelessWidget {
  const _AboutView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Logo.png', width: 100, height: 100),
            const SizedBox(height: 20),
            Text(
              'Keidot App',
              style: TextStyle(
                  color: colors.onPrimaryContainer,
                  fontSize: (size.width * 0.08)),
            ),
            const SizedBox(height: 10),
            const Text('Versión 2.1.0')
          ],
        ),
      ),
    );
  }
}
