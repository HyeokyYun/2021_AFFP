import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../login/loginPage.dart';
import '../myPage/myPage.dart';
import 'navigation.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(376, 812),
        builder: () => MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //   primarySwatch: Colors.blue,
            // ),
            home: loginPage()));
  }
}
