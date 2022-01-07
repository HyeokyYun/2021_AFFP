import 'package:wegolego_v014/controllers/auth_controller.dart';
import 'package:wegolego_v014/screens/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config.dart';
import 'home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  User? user;
  late bool isSign;

  @override
  void initState(){
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((event) => updateUserState(event));
    isSign = false;
  }

  updateUserState(event){
    setState(() {
      user = event;
      if(user == null) {
        isSign = false;
      } else {
        isSign = true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (_) {
          print("ROOT is signed in: ${_.isSignedIn.value}");
          return SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Config.screenWidth! * 0.0),
                child: (_.isSignedIn.value || isSign) ? Home() : SignIn()),
          );
        },
      ),
    );
  }
}