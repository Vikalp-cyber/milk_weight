import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Mycolors {
  static Color primarycolor = Colors.deepPurpleAccent.shade400;
  static Color secondarycolor = Colors.white;
}

class MyTextStyle {
  static TextStyle heading1 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white70,
  );

  static TextStyle heading2 = TextStyle(
    fontSize: 25.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle body = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle body2 = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static TextStyle body3 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
}
