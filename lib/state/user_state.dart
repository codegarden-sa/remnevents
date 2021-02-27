import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  bool _isLeader = false;

  // UserState({this._isLeader});
  bool get isLeader => _isLeader; 
  

  void setIsLeader(String status) {
    print('notify the listeners');
    if (status == 'leader' || status == 'admin')
      this._isLeader = true;
    else
      this._isLeader = false;
    notifyListeners();
  }
}
