import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import './home.dart';
import './auth/auth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );

  @override
  Widget build(BuildContext context) {
    final user = context.watchSignedInUser();
    user.map(
      (value) {
        _navigateToHomeScreen(context);
      },
      empty: (_) {
        _navigateToAuthScreen(context);
      },
      initializing: (_) {},
    );

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _navigateToAuthScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Navigator.of(context).pushReplacement(HomeScreen.route), //Must point to authscreen ...
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Navigator.of(context).pushReplacement(HomeScreen.route),
    );
  }
}
