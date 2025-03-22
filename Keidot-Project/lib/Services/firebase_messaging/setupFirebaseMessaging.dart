import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final Logger logger = Logger();

Future<void> setupFirebaseMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Solicita permisos (especialmente para iOS)
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    logger.i("✅ Permisos de notificación concedidos");
  } else {
    logger.w("❗ Permisos de notificación denegados");
  }

  // Maneja mensajes cuando la app está en foreground
 FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  logger.i('📩 Mensaje recibido en primer plano: ${message.notification?.title}');
  logger.d('🔎 Detalles del mensaje: ${message.notification?.body}');

  // Mostrar notificación local
  if (message.notification != null) {
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title,
      message.notification!.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        ),
      ),
    );
  }
});
  // Maneja mensajes cuando el usuario toca una notificación para abrir la app
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    logger.i('🚪 Notificación abierta por el usuario: ${message.notification?.title}');
  });

  // Si la app se abrió directamente desde una notificación mientras estaba cerrada
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      logger.i('📦 App abierta desde estado cerrado por notificación: ${message.notification?.title}');
    }
  });
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}