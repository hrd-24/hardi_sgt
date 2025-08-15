import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle bold({double? fontSize, Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle semiBold({double? fontSize, Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle medium({double? fontSize, Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle regular({double? fontSize, Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle light({double? fontSize, Color? color}) {
    return TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: fontSize,
      color: color,
    );
  }
}

class AppFontSize {
  static double h1 = 32.sp;
  static double h2 = 24.sp;
  static double h3 = 20.sp;
  static double h4 = 18.sp;
  static double h5 = 16.sp;
  static double body = 14.sp;
  static double caption = 12.sp;
  static double button = 14.sp;
  static double small = 10.sp;
  static double xSmall = 8.sp;
  static double xxSmall = 6.sp;
  static double xxxSmall = 4.sp;
}
