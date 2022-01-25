import 'package:flutter/material.dart';
import 'package:sandtonchurchapp/constants/constants.dart';

class AppState with ChangeNotifier {
  bool _isLeader = false;
  bool _isAdmin = false;
  bool _isDayEventsEmpty = false;
  bool _isViewer = false;

  bool get isLeader => _isLeader;
  bool get isAdmin => _isAdmin;
  bool get isDayEventsEmpty => _isDayEventsEmpty;

  bool get isViewer => _isViewer;

  void setIsLeader(String status) {
    if (status == AppConstants.LEADER || status == AppConstants.ADMINISTRATOR)
      this._isLeader = true;
    else
      this._isLeader = false;
    notifyListeners();
  }

  void setIsAdmin(String status) {
    if (status == AppConstants.ADMINISTRATOR)
      this._isAdmin = true;
    else
      this._isAdmin = false;
    notifyListeners();
  }

  void setIsDayEventsEmpty(bool res) {
    this._isDayEventsEmpty = res;
    notifyListeners();
  }

  void setIsViewer(String status) {
    if (status == AppConstants.VIEWER) {
      this._isViewer = true;
    } else {
      this._isViewer = false;
      notifyListeners();
    }
  }
}
