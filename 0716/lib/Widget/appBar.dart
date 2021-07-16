import 'package:des_dev_camp2021/Theme/colors.dart';
import 'package:des_dev_camp2021/Theme/text_styles.dart';
import 'package:flutter/material.dart';

AppBar customAppBar({String? title, IconButton? leading, bool? automaticallyImplyLeading}){
  return AppBar(
    //automaticallyImplyLeading: false,
    title: Text(title!,
      style: body1Style(),
    ),
    elevation: 0.0,
    backgroundColor: onSurface[50],
    titleSpacing: 10,
    iconTheme: IconThemeData(color: Colors.black),
  );
}