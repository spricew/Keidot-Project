import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

//probar si sirve los envios de mensaje/////////////////Tambien crear apratado donde en worker vera las solicitudes y las podra aceptar o no

class HomeScreenExample extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
//String? deviceToken = await getDeviceToken(); llamada
class _HomeScreenState extends State<HomeScreenExample> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _configureFirebaseMessaging();
  }

  void _configureFirebaseMessaging() {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    // Solicitar permisos para notificaciones
    _firebaseMessaging.requestPermission();

    // Obtener el token del dispositivo
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        _token = token;
      });
      print("Device Token: $token");
    });

    // Escuchar notificaciones en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notificación recibida en primer plano: ${message.notification?.title}");
      // Muestra la notificación en la aplicación
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(message.notification?.title ?? "Notificación"),
          content: Text(message.notification?.body ?? "Mensaje"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    });

    // Escuchar notificaciones en segundo plano
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  }

  // Manejador de notificaciones en segundo plano
  static Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
    print("Notificación recibida en segundo plano: ${message.notification?.title}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificaciones Push"),
      ),
      body: Center(
        child: Text(_token ?? "Cargando token..."),
      ),
    );
  }
}