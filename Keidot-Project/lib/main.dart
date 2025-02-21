import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/assignment_request/assignment_controller.dart';
import 'package:test_app/Services/assignment_request/assignment_request.dart';
import 'package:test_app/Services/location_request/location_service_controller.dart';
import 'package:test_app/Services/transaction/service_transaction_controller.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/login_screen.dart';
import 'package:test_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

/*void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ServiceTransactionController()); // Inicializa el controlador
  Get.put(LocationController());
  runApp(const MyApp());
}*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa los controladores de GetX
  Get.put(AssignmentIdController());
  Get.put(ServiceTransactionController());
  Get.put(LocationController());
  Get.put(AssignmentController());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUserName()),
      ],
      child: const MyApp(),
    ),
  );
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
          const LoginPage(), // Página de inicio => Recuerrda cambiar esto por el Login despues de la pruebas de Stripe
    );
  }
}
