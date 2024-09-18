import 'package:flutter/material.dart';

class User {
  final String uid;

  User({required this.uid});
}

class UserDetails with ChangeNotifier {
  final String uid;
  final String name;
  final String surname;
  final String cellNumber;
  final String email;
  final String status;

  UserDetails({
    required this.uid,
    required this.name,
    required this.surname,
    required this.cellNumber,
    required this.email,
    required this.status,
  });


}
