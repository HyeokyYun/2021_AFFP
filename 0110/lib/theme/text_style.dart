import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyle {
  //English Text style
  static TextStyle enHeadline5 = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    height: 24 / 24,
    wordSpacing: 0.18,
  );
  static TextStyle enBodyline1 = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    wordSpacing: 0.5,
  );
  static TextStyle enBodyline2 = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 24 / 14,
    wordSpacing: 0.25,
  );
  static TextStyle enButton = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 16 / 14,
    wordSpacing: 1.25,
  );
  static TextStyle enCaption = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 16 / 12,
    wordSpacing: 0.4,
  );

  //Korean Text Style
  static TextStyle koHeadline5 = GoogleFonts.notoSans(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 24 / 24,
    wordSpacing: 0.18,
  );
  static TextStyle koHeadline6Med = GoogleFonts.notoSans(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 24 / 20,
    wordSpacing: 0.15,
  );
  static TextStyle koHeadline6Reg = GoogleFonts.notoSans(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 24 / 20,
    wordSpacing: 0.15,
  );
  static TextStyle koHeadline1 = GoogleFonts.notoSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 24 / 18,
    wordSpacing: 0.5,
  );
  static TextStyle koHeadline3 = GoogleFonts.notoSans(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 24 / 18,
    wordSpacing: 0.5,
  );
  static TextStyle koBody1 = GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    wordSpacing: 0.5,
  );
  static TextStyle koBody2 = GoogleFonts.notoSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 24 / 14,
    wordSpacing: 0.25,
  );
  static TextStyle koButton = GoogleFonts.notoSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 16 / 14,
    wordSpacing: 1.25,
  );
  static TextStyle koCaption12 = GoogleFonts.notoSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 21 / 12,
    wordSpacing: 0.4,
  );
  static TextStyle koCaption9 = GoogleFonts.notoSans(
    fontSize: 9,
    fontWeight: FontWeight.w500,
    height: 21 / 9,
    wordSpacing: 0.4,
  );

  //Number Text Style
  static TextStyle nuHeadline = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    fontSize: 22,
    height: 22 / 22,
    wordSpacing: 0.15,
  );
  static TextStyle nuBody1 = GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
      wordSpacing: 0.15);
  static TextStyle nuSubtitle = GoogleFonts.lato(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 24 / 14,
    wordSpacing: 0.15,
  );
  static TextStyle nuCaption = GoogleFonts.lato(
    fontWeight: FontWeight.w400,
    fontSize: 9,
    height: 9 / 9,
    wordSpacing: 0.4,
  );
}


// //appbar text moomool text
// TextStyle appbarstyle({double? height, Color? color}) {
//   return GoogleFonts.patuaOne(
//     fontSize: 28,
//     fontWeight: FontWeight.w400,
//     height: height ?? 2.0,
//     letterSpacing: -0.24,
//     color: color ?? primary,
//   );
// }

// //appbar title
// TextStyle appbartitlestyle({double? height, Color? color}) {
//   return GoogleFonts.roboto(
//       fontSize: 18,
//       fontWeight: FontWeight.w400,
//       height: height ?? 2.2,
//       letterSpacing: -0.41,
//       color: color ?? grey[900]);
// }

// // fontsize 16
// TextStyle body16Style({FontWeight? fontWeight, double? height, Color? color}) {
//   return GoogleFonts.notoSans(
//       fontSize: 16,
//       fontWeight: fontWeight ?? FontWeight.w400,
//       height: height ?? 1.0,
//       letterSpacing: -0.24,
//       color: color ?? grey[900]);
// }

// // fontsize 14
// TextStyle body14Style({FontWeight? fontWeight, double? height, Color? color}) {
//   return GoogleFonts.notoSans(
//       fontSize: 14,
//       fontWeight: fontWeight ?? FontWeight.w400,
//       height: height ?? 1.5,
//       letterSpacing: -0.24,
//       color: color ?? grey[900]);
// }

// // fontsize 12
// TextStyle body12Style({FontWeight? fontWeight, double? height, Color? color}) {
//   return GoogleFonts.notoSans(
//       fontSize: 12,
//       fontWeight: fontWeight ?? FontWeight.w400,
//       height: height ?? 1.5,
//       letterSpacing: -0.24,
//       color: color ?? grey[900]);
// }

// // color와 사이즈 변경이 필요한 것
// TextStyle bodyhighlightStyle(
//     {FontWeight? fontWeight,
//     double? height,
//     Color? color,
//     double? fontsize,
//     double? fontSize}) {
//   return GoogleFonts.notoSans(
//       fontSize: fontsize ?? 14,
//       fontWeight: fontWeight ?? FontWeight.w400,
//       height: height ?? 1.0,
//       letterSpacing: -0.24,
//       color: color ?? primary);
// }

// // navigation text
// TextStyle naviStyle() {
//   return GoogleFonts.notoSans(
//     fontSize: 12,
//     fontWeight: FontWeight.w400,
//     height: 1.2,
//     letterSpacing: -0.24,
//   );
// }

// // login underbar
// TextStyle loginStyle() {
//   return GoogleFonts.notoSans(
//     fontSize: ScreenUtil().setSp(16),
//     height: 1.2,
//     letterSpacing: -0.24,
//     color: grey[700],
//     decoration: TextDecoration.underline,
//   );
// }

// // login_page
// TextStyle loginPageStyle({
//   double? fontSize,
//   Color? color,
// }) {
//   return GoogleFonts.notoSans(
//     fontSize: fontSize ?? ScreenUtil().setSp(28),
//     height: 1.2,
//     letterSpacing: -0.24,
//     color: color ?? primary,
//   );
// }
