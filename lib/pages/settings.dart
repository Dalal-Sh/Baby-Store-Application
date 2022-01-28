import 'package:shared_preferences/shared_preferences.dart';
import '../layouts/AppBar.dart';
import '../layouts/BottomSheet.dart';
import '../layouts/Drawer.dart';
import '../providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(Settings());
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      child: MyScreen(),
    );
  }
}
//ignore: must_be_immutable
class MyScreen extends StatelessWidget {
  ThemeData _lightTheme = ThemeData(
    primaryColor: Colors.white,
    accentColor: Color(0xFFff6f96),
    brightness: Brightness.light,

  );
  ThemeData _darkTheme = ThemeData(
    primaryColor: Colors.black,
    accentColor: Color(0xFFff6f96),
    brightness: Brightness.dark,

  );
  // Provider.of<AppTheme>(context, listen: false).isDark
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<AppTheme>(context).isDark?_darkTheme: _lightTheme,
      home: MyHomePage(),
    );
  }
}

//ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey, // assign key to Scaffold
      appBar: BabyAppBar(
        title: "Settings",
      ),
      drawer: BabyDrawer(),
      bottomSheet: BabyBottomSheet(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Change Mode',textScaleFactor: 1,style: TextStyle(fontFamily:'Baby')),
                trailing: IconButton(
                  icon: Icon(Icons.brightness_4),
                  onPressed: () async{
                    print("g");
                    Provider.of<AppTheme>(context, listen: false).changeTheme();
                    var modeBool =  Provider.of<AppTheme>(context, listen: false).isDark;
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isDark', modeBool);
                    // print(b);
                  },
                ),),
            ),
            Card(
              child: ListTile(
                title: Text('Change Language',textScaleFactor: 1,style: TextStyle(fontFamily:'Baby')),
                trailing: IconButton(
                  icon: Icon(Icons.language),
                  onPressed: () {
                    print("g");
                    Provider.of<AppTheme>(context, listen: false).changeTheme();
                  },
                ),),
            ),
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

