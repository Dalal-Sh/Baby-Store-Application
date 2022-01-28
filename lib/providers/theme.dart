import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier{
  bool isDark = false;

  changeTheme(){
    isDark = !isDark;
    notifyListeners();
  }
}