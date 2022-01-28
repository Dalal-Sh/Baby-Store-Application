import 'dart:async';
import 'dart:convert';

import 'package:baby_store_app/router/route_constants.dart';
import 'package:flutter/cupertino.dart';
import '../utils/api.dart';
import 'package:http/http.dart' as http;
import '../utils/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  var MainUrl = Api.authUrl;
  // var AuthKey = Api.authKey;

  String _token;
  String _userId;
  String _userName;
  String _userEmail;
  DateTime _expiryDate;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }
  String get token {
    if (_token != null) {
      return _token;
    }
  }
  // String get token {
  //   if (_expiryDate != null &&
  //       _expiryDate.isAfter(DateTime.now()) &&
  //       _token != null) {
  //     return _token;
  //   }
  // }

  String get userId {
    return _userId;
  }

  String get userEmail {
    return _userEmail;
  }

  String get userName {
    return _userName;
  }

  Future<void> logout() async {
    _token = null;
    _userEmail = null;
    _userId = null;
    _expiryDate = null;

    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    notifyListeners();

    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  // void _autologout() {
  //   if (_authTimer != null) {
  //     _authTimer.cancel();
  //   }
  //   final timetoExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timetoExpiry), logout);
  // }


  Future<bool> tryautoLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
    json.decode(pref.getString('userData')) as Map<String, Object>;

    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _userEmail = extractedUserData['userEmail'];
    _expiryDate = expiryDate;
    notifyListeners();
    // _autologout();

    return true;
  }

  Future<void> Authentication(
      String email, String password, String endpoint) async {
    try {
      final url = '${MainUrl}/${endpoint}';

      final responce = await http.post(
          Uri.parse(url),
          headers: {
            "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          },
          body:{
            "email": email,
            "password": password,
          }

      );

      final responseData = json.decode(responce.body);
       print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['token'];
      _userId = responseData['user']['id'].toString();
      _userName = responseData['user']['name'];
      _userEmail = responseData['user']['email'];
      // _expiryDate = DateTime.now()
      //     .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      // print("------");
      // _autologout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'userName': _userName,
        'userEmail': _userEmail,
        // 'expiryDate': _expiryDate.toIso8601String(),
      });
      prefs.setString('userData', userData);
      // print( prefs.getString('userData'));
      // print('check' + userData.toString());

    } catch (e) {
      throw e;
    }
  }

  Future<void> Register(
      String name, String email, String password, String endpoint) async {
    try {
      final url = '${MainUrl}/${endpoint}';
      print(url);
      final responce = await http.post(
          Uri.parse(url),
          headers: {
            "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          },
          body:{
            "name": name,
            "email": email,
            "password": password,
            "password_confirmation": password
          }

      );

      final responceData = json.decode(responce.body);
      print(responceData);

      if (responceData['error'] != null) {
        print(responceData);

        throw HttpException(responceData['error']['message']);
      }

    } catch (e) {
      throw e;
    }
  }

  Future<void> login(String email, String password) {
    return Authentication(email, password, 'login');
  }

  Future<void> signUp(String name, String email, String password) {
    return Register(name, email, password, 'register');
  }
}
