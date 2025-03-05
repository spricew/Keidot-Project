import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_request.dart';
import 'package:test_app/Services/client_request/location_request/location_service_controller.dart';
import 'package:test_app/Services/client_request/transaction/service_transaction_controller.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/login_screen.dart';
import 'package:test_app/presentation/screens/request_details_garden.dart';
import 'package:test_app/presentation/screens/stripe/keys.dart';
import 'package:test_app/presentation/worker/home_worker2.dart';
import 'package:test_app/presentation/worker/worker_job_requests_screen.dart';
import 'package:test_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = clavePublicable;
  await Stripe.instance.applySettings();
  // Inicializa los controladores de GetX
  Get.lazyPut(() => AssignmentIdController());
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
      theme: AppTheme(selectedColor: 0).theme(),
      home: const WorkerJobRequestsScreen(), // Página de inicio =>
    );
  }
}
