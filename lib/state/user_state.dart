import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/constants/constants.dart';

class UserState with ChangeNotifier {
  bool _isLeader = false;

  // UserState({this._isLeader});
  bool get isLeader => _isLeader;

  void setIsLeader(String status) {
    print('notify the listeners....');

    if (status == AppConstants.LEADER || status == AppConstants.ADMINISTRATOR)
      this._isLeader = true;
    else
      this._isLeader = false;

    print('isLeader --> '+this._isLeader.toString());
    notifyListeners();
  }
}
