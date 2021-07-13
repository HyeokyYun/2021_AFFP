import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

TextStyle titleStyle({double? height, Color? color}){
  return GoogleFonts.rubik(
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
    height: height ?? 1.4,
    color: color
  );
}

TextStyle bodyStyle1({double? height, Color? color}){
  return GoogleFonts.rubik(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
      height: height ?? 1.4,
      color: color
  );
}

TextStyle bodyStyle2({double? height, Color? color}){
  return GoogleFonts.rubik(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: height ?? 1.4,
      color: color
  );
}

TextStyle bodyStyle3({double? height, Color? color}){
  return GoogleFonts.rubik(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
      height: height ?? 1.4,
      color: color
  );
}

