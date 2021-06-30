import 'package:flutter/material.dart';
import 'package:study0628auth/views/menu.dart';
import 'package:study0628auth/views/register_screen.dart';
import 'package:study0628auth/views/login_screen.dart';

class AppRoutes{
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String menu = '/menu';

  static Map<String, WidgetBuilder> define(){
    return{
      authLogin: (context) => Login(),
      authRegister: (context)=>Register(),

      menu: (context) => MenuScreen(),
    };
  }
}