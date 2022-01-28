import '../layouts/AppBar.dart';
import '../layouts/BottomSheet.dart';
import '../classes/language.dart';
import '../localization/language_constants.dart';
import '../layouts/Drawer.dart';import '../providers/themeData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(Cart());
}
class Cart extends StatelessWidget {
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
            home: CartPage(),
          );
        } ,
      ),
    );
  }
}

class CartPage extends StatefulWidget {

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
        title: "Cart",
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
