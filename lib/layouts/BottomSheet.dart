import 'package:baby_store_app/localization/language_constants.dart';
import 'package:baby_store_app/providers/themeData.dart';
import 'package:baby_store_app/router/route_constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class BabyBottomSheet extends StatelessWidget {

  const BabyBottomSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          var isDark = notifier.darkTheme;
          return Container(
              color: isDark == false ?Colors.black : Color(0xFFf6e6d7),
              padding: EdgeInsets.all(20.0),
              child: Row(children: <Widget>[
                IconButton(
                    icon: Icon(Icons.update, color: isDark == false ? Color(0xFFf6e6d7) : Colors.black,),
                    onPressed: () {
                      print("Bottom Sheet Icon Pressed");
                    }),
                Text(getTranslated(context, 'footer'), style: TextStyle(fontFamily:'Baby', color: isDark == false ? Color(0xFFf6e6d7) : Colors.black,),)

                // Text('Developed With 🤍🖤')
              ]));
        } ,
      ),
    );
  }
}