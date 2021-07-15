import 'dart:ui';

import 'colors.dart';
import 'text_styles.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme1 = ThemeData(
  chipTheme: ChipThemeData(
    backgroundColor: Colors.white,
    disabledColor: Colors.white,
    selectedColor: primaryColor.withOpacity(0.74),

    secondarySelectedColor: secondaryColor,
    padding: EdgeInsets.all(5.0),

    labelStyle: body2Style(color: primary[900]),
    secondaryLabelStyle: body2Style(color: onSurface[50]),
    brightness: Brightness.dark,
    //border 만드는 것
    shape: StadiumBorder(
      side: BorderSide(
        color: primaryColor,
        width: 1.0,
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    labelStyle: body1Style(height: 0.0),
    hintStyle: body3Style(height: 0.0),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        //color: Colors.black,
        color: primaryColor,
      ),
    ),
    //focusColor: primary[900],
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: primary[900],
      onPrimary: onSurface[50],
      textStyle: button1Style(
        height: 1.0,
      ),
      padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(0.0),
      // ),
    ),
  ),
);
// scaffoldBackgroundColor: kShrineBackgroundWhite,
// cardColor: kShrineBackgroundWhite,
// textSelectionColor: kShrinePink100,
// errorColor: kShrineErrorRed,
// accentColor: kShrineBrown900,
// primaryColor: kShrinePink100,
// textTheme: TextTheme(button: TextStyle(fontSize: 12)),
// // primaryTextTheme: ,
// // accentTextTheme: ,

// textButtonTheme: TextButtonThemeData(
//     style: TextButton.styleFrom(
//   primary: kShrineBrown900,
// )),
//);