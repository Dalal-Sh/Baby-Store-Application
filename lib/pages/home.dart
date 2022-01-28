import 'dart:convert';
import 'dart:io';

import 'package:baby_store_app/localization/language_constants.dart';
import 'package:baby_store_app/router/route_constants.dart';
import 'package:baby_store_app/utils/api.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/themeData.dart';
import '../layouts/AppBar.dart';
import '../layouts/BottomSheet.dart';
import '../layouts/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(Home());

}
class Home extends StatelessWidget {
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
            home: HomePage(),
          );
        } ,
      ),
    );
  }
}
class HomePage extends StatelessWidget {

  @override

  Widget build(BuildContext context) {


    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      print(_categoriesJson.runtimeType);
      return _categoriesJson;

      // setState(() {
      //   _categoriesJson = jsonDecode(response.body)['data'];
      //   print(_categoriesJson);
      //   print(_categoriesJson.runtimeType);
      //   return _categoriesJson;
      //
      // });
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
        title: getTranslated(context, 'home_page'),
      ),
      drawer: BabyDrawer(),
      bottomSheet: BabyBottomSheet(),
      body: Center(
        child: Column(
          children: [

            Expanded(child: Carousel(
              animationDuration: Duration(milliseconds: 1000),
              images: [
                ExactAssetImage("images/slider/1.jpg"),
                ExactAssetImage("images/slider/2.jpg"),
                ExactAssetImage("images/slider/3.jpg"),

              ],
            ), flex: 5,),
            SizedBox(height: 30,),
            Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<List<dynamic>>(
                  future: fetchCategories(), // a previously-obtained Future<String> or null
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
                            Map<String, dynamic> category = snapshot.data[i];
                            print("++++++++++++");
                            print(category['image']['original_url']);
                            print("++++++++++++");

                            children.add(
                              Expanded(child: GestureDetector(
                                onTap: () => {
                                  Navigator.pushNamed(context, productsRoute, arguments: category['category_id'])

                                },
                                child: Container(child: Column(
                                  children: [
                                    Image.network('${category['image']['original_url']}', width: 60, height: 60,),

                                    // Image.asset('images/categories/outfits.png', width: 60, height: 60,),
                                    SizedBox(height: 10,),
                                    Text("${category['name']}", style: TextStyle(fontFamily:'Baby', fontSize: 20,),)
                                  ],)),
                              ), flex: 3,),
                            );
                          }
                          break;
                      }
                    }
                    return Center(
                      child: Row(
                        children: children,
                      ),
                    );
                  },
                )
              // child: Row(
              //   children: [
              //     Expanded(child:
              //     GestureDetector(
              //       onTap: () => {
              //
              //       },
              //       child: Container(
              //
              //         // decoration: BoxDecoration(
              //         // border: Border.all(color: Colors.yellow, style: BorderStyle.solid, width: 1),),
              //           child: Column(
              //             children: [
              //               Image.asset('images/categories/baby.png', width: 60, height: 60,),
              //               SizedBox(height: 10,),
              //               Text("Toyss", style: TextStyle(fontFamily:'Baby',fontSize: 20,),)
              //             ],)),
              //     ), flex: 3,),
              //     Expanded(child: GestureDetector(
              //       onTap: () => {
              //
              //       },
              //       child: Container(child: Column(
              //         children: [
              //           Image.asset('images/categories/outfits.png', width: 60, height: 60,),
              //           SizedBox(height: 10,),
              //           Text("Outfits", style: TextStyle(fontFamily:'Baby', fontSize: 20,),)
              //         ],)),
              //     ), flex: 3,),
              //     Expanded(child: GestureDetector(
              //       onTap: () => {
              //       },
              //       child: Container(
              //           child: Column(
              //             children: [
              //               Image.asset('images/categories/nurturing.png', width: 60, height: 60,),
              //               SizedBox(height: 10,),
              //               Text("Child Care", style: TextStyle(fontFamily:'Baby', fontSize: 20,),)
              //             ],)),
              //     ), flex: 3,),
              //     // ListView.builder(itemCount: _employeesJson.length ,itemBuilder: (context, i){
              //     //   final employee = _employeesJson[i];
              //     //   return Column(children: [
              //     //     Text("Name: ${employee["employee_name"]}\n ", style: TextStyle(fontWeight: FontWeight.bold),),
              //     //     Text("Salary: ${employee["employee_salary"]}\n ", style: TextStyle(fontWeight: FontWeight.bold)),
              //     //     Text("***********************\n", style: TextStyle(color: Colors.red)),
              //     //   ]);
              //     // }),
              //   ],
              // ),
            ), flex: 2,),
            Expanded(child: SizedBox(), flex: 2,),
          ],
        ),
      ),
      //   body: Carousel(
      //     boxFit: BoxFit.cover,
      //     autoplay: true,
      //     animationCurve: Curves.fastOutSlowIn,
      //     animationDuration: Duration(milliseconds: 1000),
      //     dotSize: 6.0,
      //     dotIncreasedColor: Color(0xFFFF335C),
      //     dotBgColor: Colors.transparent,
      //     dotPosition: DotPosition.topRight,
      //     dotVerticalPadding: 10.0,
      //     showIndicator: true,
      //     indicatorBgPadding: 7.0,
      //     images: [
      //       Image.asset('images/slider/1.jpg'),
      //       Image.asset('images/slider/2.jpg'),
      //       Image.asset('images/slider/3.jpg'),
      //     ],
      //   ),
// body: SizedBox(
//     height: 200.0,
//     width: double.infinity,
//     child: Carousel(
//              animationDuration: Duration(milliseconds: 1000),
//     images: [
//         ExactAssetImage("images/slider/1.jpg"),
//         ExactAssetImage("images/slider/2.jpg"),
//         ExactAssetImage("images/slider/3.jpg"),
//
//       ],
//     )
// ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _drawerKey.currentState.openDrawer(),
        tooltip: 'Open Music List',
        child: Icon(Icons.music_note, color: Colors.white),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
