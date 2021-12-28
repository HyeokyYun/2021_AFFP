import 'package:cap_007_auth_noti/screens/root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllerBindings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _backMessage(RemoteMessage message) async {
  print('background message ${message.notification}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backMessage);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // bind our app with the Getx Controller
      initialBinding: ControllerBindings(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.amaranthTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Root(),
    );
  }
}
