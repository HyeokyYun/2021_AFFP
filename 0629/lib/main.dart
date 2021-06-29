import 'package:flutter/material.dart';
import 'package:study0628auth/theme/routes.dart';
import 'package:study0628auth/views/opening_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Opening View Demo',
      routes: AppRoutes.define(),
      home: OpeningView(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueAccent,
      ),
    );
  }
}