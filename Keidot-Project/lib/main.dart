import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/transaction/service_transaction_controller.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/config_screen.dart';
import 'package:test_app/presentation/screens/home_page.dart';
import 'package:test_app/presentation/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ServiceTransactionController()); // Inicializa el controlador
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Cambia MaterialApp por GetMaterialApp
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 2).theme(),
      home:
          const Homepage(), // Página de inicio => Recuerrda cambiar esto por el Login despues de la pruebas de Stripe
    );
  }
}
