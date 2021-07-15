import 'package:des_dev_camp2021/Screen/login.dart';
import 'package:des_dev_camp2021/Theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Screen/home.dart';
import 'Screen/sign_up.dart';
import 'Screen/user_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => GetMaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme1,
        home: LoginPage(),
        getPages: [
          // GetPage(
          //   name: '/', page: () => SplashPage(),
          // ),
          GetPage(
            name: '/login', page: () => LoginPage(),
          ),
          GetPage(
            name: '/sign_up', page: () => SignUpPage(),
          ),
          GetPage(
            name: '/extra_info', page: () => ExtraInfoPage(),
          ),
          GetPage(
            name: '/home', page: () => HomePage(),
          ),
          // GetPage(
          //   name: '/taker', page: () => TakerPage(),
          // ),
          // GetPage(
          //   name: '/board', page: () => QuestionBoardPage(),
          // ),
          // GetPage(
          //   name: '/board_detail', page: () => BoardDetailPage(),
          // ),
          // GetPage(
          //   name: '/my', page: () => MyPage(),
          // ),
        ],
      ),
    );
  }
}
