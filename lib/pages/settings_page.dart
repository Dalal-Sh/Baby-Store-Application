import 'package:baby_store_app/layouts/AppBar.dart';
import 'package:baby_store_app/layouts/BottomSheet.dart';
import 'package:baby_store_app/layouts/Drawer.dart';
import 'package:baby_store_app/providers/theme.dart';
import 'package:baby_store_app/providers/themeData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/language.dart';
import '../localization/language_constants.dart';
import '../main.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }


  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

    return Scaffold(
      key: _drawerKey, // assign key to Scaffold
      appBar: BabyAppBar(
        title: getTranslated(context, 'settings_page'),
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
                    // Provider.of<AppTheme>(context, listen: false).changeTheme();
                    // var modeBool =  Provider.of<AppTheme>(context, listen: false).isDark;
                    // SharedPreferences prefs = await SharedPreferences.getInstance();
                    // await prefs.setBool('isDark', modeBool);
                    // print(b);
                  },
                ),),
            ),
            Card(
              child: ListTile(
                title: Text('Change Language',textScaleFactor: 1,style: TextStyle(fontFamily:'Baby')),
                trailing: IconButton(
                  icon: Icon(Icons.language),
                  onPressed: () async {
                    print("g");
                    Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
                    var modeBool =  Provider.of<AppTheme>(context, listen: false).isDark;
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isDark', modeBool);
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
      ),
    );
  }
}
