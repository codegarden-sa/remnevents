import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:sandtonchurchapp/models/user.dart';
import 'package:sandtonchurchapp/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // UserDetails _userDetailsFromFirebaseUser(FirebaseUser user) {
  //   if (user == null) return null;
  //   else return DatabaseService()
  // }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // Stream<UserDetails> get userDetails {
  //   return _auth.onAuthStateChanged
  //       //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  //       .map(_userDetailsFromFirebaseUser);
  // }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;

      // DatabaseService(uid: user.uid)
      //     .refreshUserStatus()
      //     .then((subscription) async {
      //   StreamSubscription<UserDetails> sub = subscription;
      //   sub.onData((userInfo) {

      //       print('::auth:: User uid found [status] :: ' + userInfo.status + ' [name] '+ userInfo.name);
      //     return userInfo;
      //     // if (userInfo.status != null) if (userInfo.status ==
      //     //         AppConstants.LEADER ||
      //     //     userInfo.status == AppConstants.ADMINISTRATOR) {
      //     //   setIsAdmin(userInfo.status);
      //     //   setIsLeader(userInfo.status);
      //     //   setState(() {
      //     //     validated = true;
      //       });
      // }).catchError((error) => print('::SPLASH:: error refreshing status'));
      return user.uid;
    } on PlatformException catch (platformError){
      
    }
    catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String name, String surname,
      String cellNumber, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid)
          .updateUserDetails(name, surname, cellNumber, email, 'viewer');
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (await sharedPreferences.remove('uid'))
        print('Removed uid from sharedPreferences');
      if (await sharedPreferences.remove('status'))
        print('Removed status from sharedPreferences');
      if (await sharedPreferences.remove('name'))
        print('Removed name from sharedPreferences');

      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
