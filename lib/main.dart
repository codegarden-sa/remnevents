import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0XFF075E54), accentColor: Color(0XFF25D366)),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
