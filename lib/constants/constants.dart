import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppConstants {
  //Fields

  static final String EVENT_STATUS = 'pending';
  static final String VENUE = 'local church';
  static final String USER_STATUS = 'viewer';

  //colors
  static Color guava = Color(0xffFEA47F);
  static Color grey = Color(0xff95A5A6);
  static Color skyblue = Color(0xff25CCF7);
  static Color lightgrey = Color(0xffECF0F1);
  static Color darkblue = Color(0xff34495E);
  static Color blackish = Color(0xff353b48);

  //dateTime

  static final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat hourFormat = DateFormat('Hm');


//decorations
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

  static final textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.all(12.0),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: guava, width: 2.0),
    ),
  );
}
