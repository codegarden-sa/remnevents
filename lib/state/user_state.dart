import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  bool isLeader = false;

  // UserState({this.isLeader});

  void setIsLeader(String status) {
    print('notify the listeners');
    if (status == 'leader' || status == 'admin')
      this.isLeader = true;
    else
      this.isLeader = false;
    notifyListeners();
  }
}
