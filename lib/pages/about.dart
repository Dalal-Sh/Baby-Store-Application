import '../layouts/AppBar.dart';
import '../layouts/BottomSheet.dart';
import '../providers/themeData.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import '../classes/language.dart';
import '../localization/language_constants.dart';
import '../layouts/Drawer.dart';
import '../main.dart';

void main() {
  runApp(About());
}
class About extends StatelessWidget {
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
            home: AboutPage(),
          );
        } ,
      ),
    );
  }
}


class AboutPage extends StatefulWidget {

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _drawerKey, // assign key to Scaffold
      appBar: BabyAppBar(
        title: "About Us",
      ),
      drawer: BabyDrawer(),
      bottomSheet: BabyBottomSheet(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: DottedBorder(
                  dashPattern: [8, 7],

                  color: Colors.amber,
                  radius: Radius.circular(12),
                  strokeWidth: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Container(child: Image.asset('images/slider/2.jpg',
                          width: double.infinity, fit: BoxFit.cover),),
                    ),
                  ),
                ),
              ), flex: 4,),
            Expanded(child: Container(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AutoSizeText('A perfect pieces for every day', style: TextStyle(fontFamily: 'Baby', fontWeight: FontWeight.bold, fontSize: 30,),),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(child: AutoSizeText('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis', textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left, style: TextStyle(fontFamily: 'Baby', fontSize: 20, color: Colors.blueGrey))),
                ),
                Container(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/about/signuture.png',)
                  ],),),
              ],)), flex: 4),
            SizedBox(height: 100,)



          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _drawerKey.currentState.openDrawer(),
        tooltip: 'Open Drawer',
        child: Icon(Icons.music_note, color: Colors.white),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
