import 'package:flutter/material.dart';

class AppColors {
  static Color guava = Color(0xffFEA47F);
  static Color grey = Color(0xff95A5A6);
  static Color skyblue = Color(0xff25CCF7);
  static Color lightgrey = Color(0xffECF0F1);
  static Color darkblue = Color(0xff34495E);
  static Color blackish = Color(0xff353b48);

  static List<BoxShadow> neumorpShadow = [
    BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: -2,
        offset: Offset(1, -3),
        blurRadius: 15),
    BoxShadow(
        color: blackish.withOpacity(0.2),
        spreadRadius: -1,
        offset: Offset(-1, 3),
        blurRadius: 2)
  ];
}
