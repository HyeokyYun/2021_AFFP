import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:self_study1/screens/HomeScreen.dart';

void main(){
  GetStorage.init();
  runApp(GetMaterialApp(
    home: HomeScreen(),
  ));
}