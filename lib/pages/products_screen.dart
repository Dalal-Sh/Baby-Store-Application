import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:baby_store_app/layouts/AppBar.dart';
import 'package:baby_store_app/layouts/BottomSheet.dart';
import 'package:baby_store_app/layouts/Drawer.dart';
import 'package:baby_store_app/providers/themeData.dart';
import 'package:baby_store_app/utils/api.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../localization/language_constants.dart';

void main() {
  runApp(Products());
}
class Products extends StatelessWidget {
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
            home: ProductsPage(),
          );
        } ,
      ),
    );
  }
}


class ProductsPage extends StatefulWidget {

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  /*Run API:Start*/
  var _productsJson = [];

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String userData;
  /** Get Token From Shared Preferences User Data : Start**/

  Future<List<dynamic>> fetchProducts(catId) async {
    /** Get Token From Shared Prederences : Start */
    final SharedPreferences prefs = await _prefs;
    final _userData = prefs.getString('userData') ?? null;


    final url =  Api.authUrl + '/categories/' + catId.toString() + '/products';
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
      _productsJson = jsonDecode(response.body)['data'];
      print(_productsJson);
      return _productsJson;

    } catch(error){
      print(error);
    }
  }

  /*Rin API:End*/
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        var args = ModalRoute.of(context).settings;
        int categoryId = args.arguments;
        print("Dds");
        print(args);
        print(args.arguments);
        print(categoryId);
        fetchProducts(categoryId);
      });
    });

    super.didChangeDependencies();
  }
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    var args = ModalRoute.of(context).settings;
    int categoryId = args.arguments ?? 1;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _drawerKey, // assign key to Scaffold
        appBar: BabyAppBar(
          title: getTranslated(context, 'products_title'),
        ),
        drawer: BabyDrawer(),
        bottomSheet: BabyBottomSheet(),
        body: FutureBuilder<List<dynamic>>(
          future: fetchProducts(categoryId), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            List<Widget> children;
            List<Widget> childrenTitle;
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
                    Center(
                      child: SizedBox(
                        child: const CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(''),
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
                  childrenTitle = <Widget>[];
                  children = <Widget>[];
                  childrenTitle.add(
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.5),
                        child: Center(
                          child: Column(
                            children: [
                              AutoSizeText('${snapshot.data[0]['category']['name']}', style: TextStyle(fontSize: 25, fontFamily: 'Baby', fontWeight: FontWeight.bold),),
                              SizedBox(height: 15,),
                              AutoSizeText("${getTranslated(context, 'products_text')} ${getTranslated(context, 'toys')}",
                                  style: TextStyle(fontSize: 15, fontFamily: 'Baby'))
                            ],),
                        ),
                      ),
                    ),
                           );
                  for(var i=0; i< snapshot.data.length;i++){
                    Map<String, dynamic> product = snapshot.data[i];
                    children.add(
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Image.network('${product['image']['original_url']}',),
                              ),
                            ),
                            AutoSizeText('${product['title']}', style: TextStyle(fontFamily: 'Baby', fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 5,),
                            RatingBar.builder(
                              itemSize: 20,
                              initialRating: product['rate'].toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(height: 5,),
                            AutoSizeText('${product['price']}\$', style: TextStyle(fontFamily: 'Baby', fontSize: 15)),

                          ],),
                        ), flex: 4,),

                    );

                  }
                  break;
              }
            }

            return Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.5),
                    child: Column(
                      children: childrenTitle != null ? childrenTitle : [],),
                  ),
                ),
                Row(
                  children: children,
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _drawerKey.currentState.openDrawer(),
          tooltip: 'Open Music List',
          child: Icon(Icons.music_note, color: Colors.white),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

/*First Page:Start*/
class BabiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.5),
            child: Column(
              children: [
                AutoSizeText(getTranslated(context, 'toys'), style: TextStyle(fontSize: 25, fontFamily: 'Baby', fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                AutoSizeText("${getTranslated(context, 'products_text')} ${getTranslated(context, 'toys')}",
                    style: TextStyle(fontSize: 15, fontFamily: 'Baby'))
              ],),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(children: [
                Container(
                  color: Colors.red,
                  child: Image.asset('images/products/toys/bear.jpg'),
                ),
                AutoSizeText('Toy Name', style: TextStyle(fontFamily: 'Baby', fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 5,),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 5,),
                AutoSizeText('58 S.P', style: TextStyle(fontFamily: 'Baby', fontSize: 15)),

              ],), flex: 4,),
            Expanded(
              child: Column(children: [
                Container(
                  child: Image.asset('images/products/toys/elephant.jpg'),
                ),
                AutoSizeText('Toy Name', style: TextStyle(fontFamily: 'Baby', fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 5,),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 5,),
                AutoSizeText('58 S.P', style: TextStyle(fontFamily: 'Baby', fontSize: 15)),

              ],), flex: 4,),
            Expanded(
              child: Column(children: [
                Container(
                  child: Image.asset('images/products/toys/boat.jpg'),
                ),
                AutoSizeText('Toy Name', style: TextStyle(fontFamily: 'Baby', fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 5,),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 5,),
                AutoSizeText('58 S.P', style: TextStyle(fontFamily: 'Baby', fontSize: 15)),

              ],), flex: 4,),
          ],
        ),
      ],
    );
  }
}
/*First Page:End*/

/*Second Page:Start */
class OutfitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.5),
            child: Column(
              children: [
                AutoSizeText(getTranslated(context, 'outfits'), style: TextStyle(fontSize: 25, fontFamily: 'Baby', fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                AutoSizeText("${getTranslated(context, 'products_text')} ${getTranslated(context, 'outfits_products')}",
                    style: TextStyle(fontSize: 15, fontFamily: 'Baby'))
              ],),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(children: [
                Container(
                  child: Image.asset('images/products/outfits/1.jpg'),
                ),
                AutoSizeText('Outfit Name', style: TextStyle(fontFamily: 'Baby', fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 5,),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 5,),
                AutoSizeText('58 S.P', style: TextStyle(fontFamily: 'Baby', fontSize: 15)),

              ],), flex: 4,),
            Expanded(
              child: Column(children: [
                Container(
                  child: Image.asset('images/products/outfits/2.jpg'),
                ),
                AutoSizeText('Outfit Name', style: TextStyle(fontFamily: 'Baby', fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 5,),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 5,),
                AutoSizeText('58 S.P', style: TextStyle(fontFamily: 'Baby', fontSize: 15)),

              ],), flex: 4,),
          ],
        ),
      ],
    );
  }
}
/*Second Page:End */
/*Third Page:Start*/
class NurturingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.5),
            child: Column(
              children: [
                AutoSizeText('Nurturing', style: TextStyle(fontSize: 25, fontFamily: 'Baby', fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                AutoSizeText('Check out Available Nurturing Products',
                    style: TextStyle(fontSize: 15, fontFamily: 'Baby'))
              ],),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(children: [
                Container(
                  child: Image.asset('images/products/nurturing/1.jpg'),
                ),
                AutoSizeText('Item Name', style: TextStyle(fontFamily: 'Baby', fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 5,),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 5,),
                AutoSizeText('58 S.P', style: TextStyle(fontFamily: 'Baby', fontSize: 15)),

              ],), flex: 4,),
            Expanded(
              child: Column(children: [
                Container(
                  child: Image.asset('images/products/nurturing/2.jpg'),
                ),
                AutoSizeText('Item Name', style: TextStyle(fontFamily: 'Baby', fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 5,),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 5,),
                AutoSizeText('58 S.P', style: TextStyle(fontFamily: 'Baby', fontSize: 15)),

              ],), flex: 4,),
            Expanded(
              child: Column(children: [
                Container(
                  child: Image.asset('images/products/nurturing/3.jpg'),
                ),
                AutoSizeText('Item Name', style: TextStyle(fontFamily: 'Baby', fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 5,),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 5,),
                AutoSizeText('58 S.P', style: TextStyle(fontFamily: 'Baby', fontSize: 15)),

              ],), flex: 4,),
          ],
        ),
      ],
    );
  }
}
/*Third Page:End*/

/*Fourth Page:Start*/
class ChildCareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.5),
            child: Column(
              children: [
                AutoSizeText(getTranslated(context, 'child_care') , style: TextStyle(fontSize: 25, fontFamily: 'Baby', fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                AutoSizeText("${getTranslated(context, 'products_text')} ${getTranslated(context, 'child_care_products')} ",
                    style: TextStyle(fontSize: 15, fontFamily: 'Baby'))
              ],),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(children: [
                Container(
                  child: Image.asset('images/products/nurturing/1.jpg'),
                ),
                AutoSizeText('Item Name', style: TextStyle(fontFamily: 'Baby', fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 5,),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 5,),
                AutoSizeText('58 S.P', style: TextStyle(fontFamily: 'Baby', fontSize: 15)),

              ],), flex: 4,),
            Expanded(
              child: Column(children: [
                Container(
                  child: Image.asset('images/products/nurturing/2.jpg'),
                ),
                AutoSizeText('Item Name', style: TextStyle(fontFamily: 'Baby', fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 5,),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 5,),
                AutoSizeText('58 S.P', style: TextStyle(fontFamily: 'Baby', fontSize: 15)),

              ],), flex: 4,),
            Expanded(
              child: Column(children: [
                Container(
                  child: Image.asset('images/products/nurturing/3.jpg'),
                ),
                AutoSizeText('Item Name', style: TextStyle(fontFamily: 'Baby', fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 5,),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 5,),
                AutoSizeText('58 S.P', style: TextStyle(fontFamily: 'Baby', fontSize: 15)),

              ],), flex: 4,),
          ],
        ),
      ],
    );
  }
}
/*Fourth Page:End*/




// return CustomScrollView(
// primary: false,
// slivers: <Widget>[
// SliverPadding(
// padding: const EdgeInsets.all(20),
// sliver: SliverGrid.count(
// crossAxisSpacing: 10,
// mainAxisSpacing: 10,
// crossAxisCount: 2,
// children: <Widget>[
// Container(
// padding: const EdgeInsets.all(8),
// child: const Text("He'd have you all unravel at the"),
// color: Colors.green[100],
// ),
// Container(
// padding: const EdgeInsets.all(8),
// child: const Text('Heed not the rabble'),
// color: Colors.green[200],
// ),
// Container(
// padding: const EdgeInsets.all(8),
// child: const Text('Sound of screams but the'),
// color: Colors.green[300],
// ),
// Container(
// padding: const EdgeInsets.all(8),
// child: const Text('Who scream'),
// color: Colors.green[400],
// ),
// Container(
// padding: const EdgeInsets.all(8),
// child: const Text('Revolution is coming...'),
// color: Colors.green[500],
// ),
// Container(
// padding: const EdgeInsets.all(8),
// child: const Text('Revolution, they...'),
// color: Colors.green[600],
// ),
// ],
// ),
// ),
// ],
// );