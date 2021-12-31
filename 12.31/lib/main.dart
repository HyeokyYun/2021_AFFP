import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wegolego_v014/controllers/noti_controller.dart';
import 'package:wegolego_v014/screens/chennels/chennel_list.dart';
import 'package:wegolego_v014/screens/root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllerBindings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

Future<void> _backMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('background message ${message.notification}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backMessage);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NotiController c = Get.put(NotiController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // bind our app with the Getx Controller
      initialBinding: ControllerBindings(),
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   textTheme: GoogleFonts.amaranthTextTheme(
      //     Theme.of(context).textTheme,
      //   ),
      // ),
      home: FutureBuilder(
          future: c.initialize(),
          builder: (context, snapshot) {
            return Root();}
      ),
    );
  }

  // Future<dynamic> onSelectNotification() async{
  //   Get.to(()=> const ChannelList());
  // }
}
