import 'dart:convert';

import 'package:baby_store_app/utils/api.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../layouts/AppBar.dart';
import '../layouts/BottomSheet.dart';
import '../layouts/Drawer.dart';
import '../providers/themeData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/language_constants.dart';

void main() {
  runApp(WashList());
}
class WashList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {

          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Theme Provider',
            theme: notifier.darkTheme ? dark : light,
            home: WashListPage(),
          );
        } ,
      ),
    );
  }
}

class WashListPage extends StatefulWidget {

  @override
  _WashListPageState createState() => _WashListPageState();
}

class _WashListPageState extends State<WashListPage> {
  var _categoriesJson = [];

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String userData;
  @override
  /** Get Token From Shared Preferences User Data : Start**/

  Future<List<dynamic>> fetchCategories() async {
    /** Get Token From Shared Prederences : Start */
    final SharedPreferences prefs = await _prefs;
    final _userData = prefs.getString('userData') ?? null;


    final url =  Api.authUrl + '/categories/1';
    Map userData = json.decode(_userData);
    print(userData['token']);
    try{
      final response = await get(
        Uri.parse(url),
        headers: {
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          'Authorization': 'Bearer ${userData['token']}',
        },
      );
      final jsonData = response;
      _categoriesJson = jsonDecode(response.body)['data'];
      print(_categoriesJson);
      return _categoriesJson;

    } catch(error){
      print(error);
    }
  }
  /** Get Token From Shared Preferences User Data : End **/

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _drawerKey, // assign key to Scaffold
      appBar: BabyAppBar(
        title: "WashList",
      ),
      drawer: BabyDrawer(),
      bottomSheet: BabyBottomSheet(),
      body: Center(
        child: Text('Coming Soon'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _drawerKey.currentState.openDrawer(),
        tooltip: 'Open Drawer',
        child: Icon(Icons.music_note, color: Colors.white),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
