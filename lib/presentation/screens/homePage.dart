import 'package:flutter/material.dart';
import 'package:test_app/widgets/custom_appbar.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Keidot',
        backgroundColor: Colors.white,
      ),
    );
  }
}
