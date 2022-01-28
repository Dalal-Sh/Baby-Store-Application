import 'package:baby_store_app/classes/language.dart';
import 'package:baby_store_app/localization/language_constants.dart';
import 'package:baby_store_app/providers/theme_changer.dart';
import 'package:flutter/material.dart';
import '../providers/themeData.dart';
import 'package:baby_store_app/providers/auth.dart';
import 'package:provider/provider.dart';
import '../main.dart';
class BabyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BabyAppBar({key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          void _changeLanguage(Language language) async {
            Locale _locale = await setLocale(language.languageCode);
            MyApp.setLocale(context, _locale);
          }
          return  AppBar(
            backgroundColor: notifier.darkTheme ? Colors.white : Colors.white,
            title: Text("${this.title ?? 'Baby Store'}", style: TextStyle(fontFamily:'Baby', color: Color(0xFFff6f96), fontWeight: FontWeight.bold),),
            iconTheme: IconThemeData(color: Color(0xFFff6f96)),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<Language>(
                  underline: SizedBox(),
                  icon: Icon(
                    Icons.language,
                    color: Color(0xFFff6f96),
                  ),
                  onChanged: (Language language) {
                    _changeLanguage(language);
                  },
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                         Text(e.name)
                        ],
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.brightness_4),
                tooltip: 'Show Cart',
                onPressed: () {
                  notifier.toggleTheme();
                  ThemeBuilder.of(context).changeTheme();

                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Sign Out',
                onPressed: () {

                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return MyApp();
                  }));
                  Provider.of<Auth>(context, listen: false).logout();

                },
              ),
            ],
          );
        } ,
      ),
    );

  }

  static final _appBar = AppBar();
  @override
  Size get preferredSize => _appBar.preferredSize;
}
//
// appBar: AppBar(
//   title: Text(getTranslated(context, 'home_page')),
//   actions: <Widget>[
//     Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: DropdownButton<Language>(
//         underline: SizedBox(),
//         icon: Icon(
//           Icons.language,
//           color: Colors.white,
//         ),
//         onChanged: (Language language) {
//           _changeLanguage(language);
//         },
//         items: Language.languageList()
//             .map<DropdownMenuItem<Language>>(
//               (e) => DropdownMenuItem<Language>(
//                 value: e,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     Text(
//                       e.flag,
//                       style: TextStyle(fontSize: 30),
//                     ),
//                     Text(e.name)
//                   ],
//                 ),
//               ),
//             )
//             .toList(),
//       ),
//     ),
//   ],
// ),