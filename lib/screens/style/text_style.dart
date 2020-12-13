

import 'package:flutter/material.dart';

String getFontFamily( bool isAmatic ){
  return isAmatic ? 'Amatic': 'Biryani';
}

FontWeight getFontWeight( String weight ){
  switch (weight) {
    /// Light
    case 'l':
      return FontWeight.w300;
    /// Bold
    case 'b':
      return FontWeight.w700;
    /// Regular
    case 'r':
      return FontWeight.w400;
    default:
      return FontWeight.w500;
  }
}

TextStyle getTextStyle( bool isAmatic, double fontSize, String weight, Color color ){
  return TextStyle(
    fontFamily: getFontFamily(isAmatic),
    fontWeight: getFontWeight(weight),
    fontSize: fontSize,
    color: color,
  );
}