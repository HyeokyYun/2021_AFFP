import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:wegolego_jjinjjin_0907/pages/dashboard/dashboard.dart';
import 'package:wegolego_jjinjjin_0907/pages/dashboard/dashboard_binding.dart';
import 'package:wegolego_jjinjjin_0907/pages/login/login_page.dart';


Future<void> _backMessage(RemoteMessage message) async {
  print('background message ${message.notification}');
}
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DashBoardBinding().dependencies();
  FirebaseMessaging.onBackgroundMessage(_backMessage);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(376, 812),
        builder: ()=>
            GetMaterialApp(

              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              getPages: [
                GetPage(name: "/", page:()=> LoginPage(),

                    //   MyDashBoard(),
                    binding: DashBoardBinding()

                )
              ],
              home: IntroScreen(),
            )
    );
  }
}


class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    return new SplashScreen(
        useLoader: true,
        //  loadingTextPadding: EdgeInsets.all(0),
        loadingText: Text(""),
        navigateAfterSeconds: result != null ?  MyDashBoard() : LoginPage(),
        seconds: 3,
        title: new Text(
          'Welcome To Meet up!',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: Image.asset('images/MM_logo.png', fit: BoxFit.scaleDown),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("flutter"),
        loaderColor: Colors.red);
  }
}