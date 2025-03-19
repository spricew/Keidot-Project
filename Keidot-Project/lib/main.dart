import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/client_request/assignment_request/GET/assignment_in_wait.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/Services/client_request/review_request/review_controller.dart';
import 'package:test_app/Services/client_request/transaction/service_transaction_controller.dart';
import 'package:test_app/config/theme/app_theme.dart';
import 'package:test_app/firebase_options.dart';
import 'package:test_app/presentation/screens/login_screen.dart';
import 'package:test_app/presentation/screens/stripe/keys.dart';
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
  Get.put(AssignmentInWait());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Configuración automática
  );
  // Inicializa Firebase Messaging para primer y segundo plano
  await setupFirebaseMessaging();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUserName()),
      ],
      child: const MyApp(),
    ),
  );
}

//manejar los mensajes en primer plano
// Configura Firebase Messaging
Future<void> setupFirebaseMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Solicita permisos en iOS
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // Obtén el token de FCM
  String? token = await messaging.getToken();
  print('FCM Token: $token');

  // Maneja mensajes en primer plano
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Mensaje recibido en primer plano: ${message.notification?.title}');
    // Aquí puedes mostrar una notificación local
  });
}

//manejar los mensajes en segundo plano
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Mensaje recibido en segundo plano: ${message.notification?.title}');
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
          const LoginPage(), // Ve cambiando esta cosa para las pantallas que quieras ver Diego gay
    );
  }
}
