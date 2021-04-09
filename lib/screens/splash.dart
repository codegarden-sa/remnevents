import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/models/user.dart';
import 'dart:async';
import 'package:sandtonchurchapp/screens/home.dart';
import 'package:sandtonchurchapp/constants/loading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sandtonchurchapp/services/auth.dart';
import 'package:sandtonchurchapp/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:sandtonchurchapp/state/app_state.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool validated = false;
  String uid;

  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(Duration(seconds: 3), () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      });
    });
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final AuthService _auth = AuthService();

    var storedUid = sharedPreferences.getString('uid');
    if (storedUid != null) {
      //this makes sure that if the user status changes, next time they re-open the app
      //the status will be updated to give/revoke access
      uid = storedUid;
      final setIsLeader =
          Provider.of<AppState>(context, listen: false).setIsLeader;
      final setIsAdmin =
          Provider.of<AppState>(context, listen: false).setIsAdmin;

      DatabaseService(uid: storedUid)
          .refreshUserStatus()
          .then((subscription) async {
        StreamSubscription<UserDetails> sub = subscription;
        sub.onData((userInfo) {
          if (userInfo.status != null) if (userInfo.status ==
                  AppConstants.LEADER ||
              userInfo.status == AppConstants.ADMINISTRATOR) {
            setIsAdmin(userInfo.status);
            setIsLeader(userInfo.status);
            setState(() {
              validated = true;
            });
            print('::SPLASH:: User uid found [status] :: ' +
                userInfo.status +
                ' [name] ' +
                userInfo.name);
          }
        });
      }).catchError((error) => print('::SPLASH:: error refreshing status'));
    } else {
      dynamic anonUser = await _auth.signInAnon();
      print(':: spash :: anonymous user uid ' + anonUser.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.darkblue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Image.asset(
              'assets/images/logo.png',
              height: 120,
            ),
            SizedBox(
              height: 20,
            ),
            SpinKitThreeBounce(
              color: AppConstants.guava,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
