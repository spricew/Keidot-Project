import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/client_request/assignment_request/GET/assignment_in_wait.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/Services/client_request/review_request/review_controller.dart';
import 'package:test_app/Services/client_request/transaction/service_transaction_controller.dart';
import 'package:test_app/Services/firebase_messaging/setupFirebaseMessaging.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/firebase_options.dart';
import 'package:test_app/presentation/screens/login_screen.dart';
import 'package:test_app/presentation/screens/stripe/keys.dart';
import 'package:test_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

final Logger logger = Logger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Configura Stripe
  Stripe.publishableKey = clavePublicable;
  await Stripe.instance.applySettings();

  // Inicializa Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Configura Firebase Messaging
  await setupFirebaseMessaging();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Inicializa controladores GetX
  Get.lazyPut(() => AssignmentIdController());
  Get.put(ServiceTransactionController());
  Get.lazyPut(() => ReviewController());
  Get.put(AssignmentInWait());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUserName()),
      ],
      child: const MyApp(),
    ),
  );
}

// Maneja notificaciones en segundo plano
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.i('🌙 Mensaje recibido en segundo plano: ${message.notification?.title}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 2).theme(),
      home: const LoginPage(),
    );
  }
}
