import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuilderController extends GetxController{

  late bool dark=true;

  changetrue(){
    dark = true;
    update();
  }
  changefalse(){
    dark = false;
    update();
  }
}