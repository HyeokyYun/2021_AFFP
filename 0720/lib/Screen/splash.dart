import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:async';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    //Navigator.of(context).pushReplacementNamed('/HomeScreen');
    Get.offAllNamed('/login');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff266665),
      body: new Column(
          children:<Widget> [
            SizedBox(
              height:MediaQuery.of(context).size.height/4,
            ),
            new Image.asset(
              'images/mm.png',
              width:MediaQuery.of(context).size.width/3,
              height: 200,
            ),
            Text('Loading . . .',
              style: TextStyle(
                color: Colors.white,
              )
              ,
            ),
            SizedBox(
              height:MediaQuery.of(context).size.height/5,
            ),


            LinearProgressIndicator(
              minHeight: 5,
              backgroundColor: Color(0xffFBF2DE),
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xffE7A001)
              ),
            ),

            /*
            CircularProgressIndicator(
              valueColor:
              AlwaysSt,
            ),*/
          ]
      ),
    );
  }
}