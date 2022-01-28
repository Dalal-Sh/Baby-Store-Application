import 'package:auto_size_text/auto_size_text.dart';
import 'package:baby_store_app/layouts/AppBar.dart';
import 'package:baby_store_app/layouts/BottomSheet.dart';
import 'package:baby_store_app/layouts/Drawer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../classes/language.dart';
import '../localization/language_constants.dart';
import '../layouts/Drawer.dart';
class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey, // assign key to Scaffold
      appBar: BabyAppBar(
        title: getTranslated(context, 'cart_page'),
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
