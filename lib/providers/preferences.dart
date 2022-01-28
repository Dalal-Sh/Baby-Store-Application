import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences with ChangeNotifier{
  String prefData ;

  Future<String> getPrefs(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefData = prefs.getString(key);
    return prefData;
  }
  }