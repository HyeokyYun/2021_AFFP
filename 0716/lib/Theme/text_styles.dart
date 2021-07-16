import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

//page name
TextStyle body1Style({double? height, Color? color}) {
  return GoogleFonts.notoSans(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: height ?? 1.6,
      letterSpacing: 2.0,
      color: color ?? onSurface[900]);
}

//body내 제목
TextStyle body2Style({double? height, Color? color}) {
  return GoogleFonts.notoSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: height ?? 2.0,
      letterSpacing: 1.5,
      color: color ?? onSurface[900]);
}

//body내 소제목
TextStyle body3Style({double? height, Color? color}) {
  return GoogleFonts.notoSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: height ?? 2.0,
      letterSpacing: 1.5,
      color: color ?? onSurface[800]);
}

//일반적인 button text 사이즈
TextStyle button1Style({double? height, Color? color}) {
  return GoogleFonts.notoSans(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      height: height ?? 1.6,
      letterSpacing: 1.5,
      color: color ?? onSurface[50]);
}