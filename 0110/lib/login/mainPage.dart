import 'signUpPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'emailLoginPage.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: camel_case_types
class mainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('main page'),
              //SizedBox(height: ScreenUtil().setHeight(50)),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
