import 'package:baby_store_app/providers/auth.dart';

import 'package:baby_store_app/providers/themeData.dart';
import 'package:baby_store_app/providers/theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'localization/demo_localization.dart';
import 'router/custom_router.dart';
import 'router/route_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/language_constants.dart';

void main() => runApp(
    ChangeNotifierProvider(
      create: (_) => Auth(),
      child: MyApp(),
    )
);

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
        ),
      );
    } else {
    return ThemeBuilder(
  defaultBrightness: Brightness.light,
  builder: (context, _brightness) {
    print("wow");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Baby Store",
      theme: ThemeData(primarySwatch: Colors.pink, brightness: _brightness),
      locale: _locale,
      supportedLocales: [
        Locale("en", "US"),
        Locale("fa", "IR"),
        Locale("ar", "SA"),
        Locale("hi", "IN")
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      onGenerateRoute: CustomRouter.generatedRoute,
      initialRoute: firstRoute,
      //  initialRoute: loginRoute,

    );
  },
);
    }
  }
}
