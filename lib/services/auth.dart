import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:remnevents/constants/constants.dart';
import 'package:remnevents/models/user.dart' as app_models;
import 'package:remnevents/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  // create user obj based on firebase user
  app_models.User? _userFromFirebaseUser(firebase_auth.UserCredential userCredential) {
    return userCredential.user != null ? app_models.User(uid: userCredential.user!.uid) : null;
  }

  Stream<app_models.User?> get user {
    return _auth.authStateChanges()
        .map((firebaseUser) => firebaseUser != null ? app_models.User(uid: firebaseUser.uid) : null);
  }

  // sign in anon
  Future<app_models.User?> signInAnon() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      firebase_auth.UserCredential result = await _auth.signInAnonymously();
      print(':: auth :: signed in anonymously');
      await sharedPreferences.setString('status', AppConstants.VIEWER);
      return _userFromFirebaseUser(result);
    } catch (e) {
      print('Error signing in anonymously: ${e.toString()}');
      return null;
    }
  }

  // sign in with email and password
  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      firebase_auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user?.uid;
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      return null;
    } catch (error) {
      print('Error signing in: ${error.toString()}');
      return null;
    }
  }

  // register with email and password
  Future<app_models.User?> registerWithEmailAndPassword(String name, String surname,
      String cellNumber, String email, String password) async {
    try {
      firebase_auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      
      if (result.user != null) {
        await DatabaseService(uid: result.user!.uid)
            .updateUserDetails(name, surname, cellNumber, email, 'viewer');
      }
      return _userFromFirebaseUser(result);
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      return null;
    } catch (error) {
      print('Error registering user: ${error.toString()}');
      return null;
    }
  }

  // sign out
  Future<void> signOut() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.remove('uid');
      await sharedPreferences.remove('status');
      await sharedPreferences.remove('name');
      await _auth.signOut();
    } catch (error) {
      print('Error signing out: ${error.toString()}');
    }
  }
}
