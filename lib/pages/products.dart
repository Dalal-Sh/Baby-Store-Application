import 'package:auto_size_text/auto_size_text.dart';
import '../layouts/AppBar.dart';
import '../layouts/BottomSheet.dart';
import '../layouts/Drawer.dart';
import '../providers/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../main.dart';
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

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _drawerKey, // assign key to Scaffold
        appBar: BabyAppBar(
          title: "Products",
        ),
        drawer: BabyDrawer(),
        bottomSheet: BabyBottomSheet(),
        body: TabBarView(
          children: [
            BabiesScreen(),
            OutfitScreen(),
            // NurturingScreen(),
            ChildCareScreen(),

          ],
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
                AutoSizeText('Toys', style: TextStyle(fontSize: 25, fontFamily: 'Baby', fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                AutoSizeText('Check out Available Toys Products',
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
                AutoSizeText('Outfits', style: TextStyle(fontSize: 25, fontFamily: 'Baby', fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                AutoSizeText('Check out Available Outfits Products',
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
                AutoSizeText('Child Care', style: TextStyle(fontSize: 25, fontFamily: 'Baby', fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                AutoSizeText('Check out Available Child Care Products',
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
