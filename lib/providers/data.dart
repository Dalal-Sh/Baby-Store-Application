import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../utils/api.dart';
import 'package:http/http.dart' as http;
import '../utils/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data with ChangeNotifier {
  var MainUrl = Api.authUrl;
  // var AuthKey = Api.authKey;

  int _categoryId;
  String _categoryName;
  String _langId;



  int get categoryId {
    if (_categoryId != null) {
      return _categoryId;
    }
  }
  String get categoryName {
    if (_categoryName != null) {
      return _categoryName;
    }
  }
  String get langId {
    if (_langId != null) {
      return _langId;
    }
  }


  Future<void> Categories(
      int langId, String endpoint) async {
    try {
      final url = '${MainUrl}/${endpoint}/langId';
      final response = await http.get(
          Uri.parse(url),
          headers: {
            "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          },
      );

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      // _token = responseData['token'];
      // _userId = responseData['user']['id'].toString();
      // _userName = responseData['user']['name'];
      // _userEmail = responseData['user']['email'];

      notifyListeners();

    } catch (e) {
      throw e;
    }
  }



  Future<void> getCategories(int langId) {
    return Categories(langId, 'categories');
  }

}
