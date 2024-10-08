import 'package:flutter/material.dart';
import 'constants.dart';
import 'main.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// Future<void> _messageHandler(RemoteMessage message) async {
//   print('background message ${message.notification.body}');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_messageHandler);

  Constants.setEnvironment(Environment.DEV);
  mainDelegate();
}
