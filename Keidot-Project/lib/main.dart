import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_request.dart';
import 'package:test_app/Services/client_request/review_request/review_controller.dart';
import 'package:test_app/Services/client_request/transaction/service_transaction_controller.dart';
import 'package:test_app/Services/worker_request/reviews_request/review_controllerGet.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/presentation/screens/login_screen.dart';
import 'package:test_app/presentation/screens/review_screen.dart';
import 'package:test_app/presentation/screens/stripe/keys.dart';
import 'package:test_app/presentation/worker/reviews_to_worker.dart';
import 'package:test_app/presentation/worker/reviews_worker.dart';
import 'package:test_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = clavePublicable;
  await Stripe.instance.applySettings();
  // Inicializa los controladores de GetX
  Get.lazyPut(() => AssignmentIdController());
  Get.put(ServiceTransactionController());
  Get.lazyPut(() => ReviewController());
  Get.put(AssignmentService());
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
      home: ReviewsWorkerScreen(), // Ve cambiando esta cosa para las pantallas que quieras ver Diego gay
    );
  }
}
