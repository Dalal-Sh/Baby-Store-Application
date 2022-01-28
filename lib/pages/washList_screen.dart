import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:baby_store_app/layouts/AppBar.dart';
import 'package:baby_store_app/layouts/BottomSheet.dart';
import 'package:baby_store_app/layouts/Drawer.dart';
import 'package:baby_store_app/utils/api.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../localization/language_constants.dart';

class WashListPage extends StatefulWidget {
  WashListPage({Key key}) : super(key: key);

  @override
  _WashListPageState createState() => _WashListPageState();
}

class _WashListPageState extends State<WashListPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  var _washListJson = [];

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String userData;
  @override
  /** Get Token From Shared Preferences User Data : Start**/

  Future<List<dynamic>> fetchWashList() async {
    /** Get Token From Shared Prederences : Start */
    final SharedPreferences prefs = await _prefs;
    final _userData = prefs.getString('userData') ?? null;


    final url =  Api.authUrl + '/washList';
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
      _washListJson = jsonDecode(response.body)['data'];
      print(_washListJson);
      return _washListJson;

    } catch(error){
      print(error);
    }
  }
  /** Get Token From Shared Preferences User Data : End **/

  @override
  void initState() {
    super.initState();
    fetchWashList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey, // assign key to Scaffold
      appBar: BabyAppBar(
        title: getTranslated(context, 'washList_page'),
      ),
      drawer: BabyDrawer(),
      bottomSheet: BabyBottomSheet(),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: fetchWashList(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            List<Widget> children;
            if (snapshot.hasError) {
              children = <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            }
            else {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  children = <Widget>[
                    Icon(
                      Icons.info,
                      color: Colors.blue,
                      size: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Select a lot'),
                    )
                  ];
                  break;
                case ConnectionState.waiting:
                  children = <Widget>[
                    SizedBox(
                      child: const CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting bids...'),
                    )
                  ];
                  break;
                case ConnectionState.active:
                  children = <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('\$${snapshot.data[0]}'),
                    )
                  ];
                  break;
                case ConnectionState.done:
                  children = <Widget>[];

                  for(var i=0; i< snapshot.data.length;i++){
                    Map<String, dynamic> washListItem = snapshot.data[i]["product"];
                    children.add(Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text('${washListItem["title"]}',textScaleFactor: 1,style: TextStyle(fontFamily:'Baby')),
                          trailing: IconButton(
                            icon: Icon(Icons.favorite, color: Color(0xFFff6f96),),
                            onPressed: () async {},
                          ),),
                      ),

                    ));
                  }
                  break;
              }
            }
            return Center(
              child: Column(
                children: children,
              ),
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _drawerKey.currentState.openDrawer(),
        tooltip: 'Open Drawer',
        child: Icon(Icons.music_note, color: Colors.white),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
