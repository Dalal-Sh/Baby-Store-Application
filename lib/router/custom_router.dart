import 'package:baby_store_app/pages/auth/login_screen.dart';
import 'package:baby_store_app/pages/auth/signup_screen.dart';
import 'package:baby_store_app/providers/auth.dart';
import 'package:baby_store_app/pages/cart_screen.dart';
import 'package:flutter/material.dart';
import '../pages/first_screen.dart';
import '../pages/about_screen.dart';
import '../pages/products_screen.dart';
import '../pages/home.dart';
// import '../pages/home_page.dart';
import '../pages/not_found_page.dart';
import '../pages/settings_page.dart';
import '../pages/washList_screen.dart';
import '../pages/splash_screen.dart';
import '../router/route_constants.dart';

class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case firstRoute:
        return MaterialPageRoute(builder: (_) => FirstPage(), settings: settings);
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage(), settings: settings);
      case signupRoute:
        return MaterialPageRoute(builder: (_) => signupPage(), settings: settings);
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage(), settings: settings);
      case aboutRoute:
        return MaterialPageRoute(builder: (_) => AboutPage(), settings: settings);
      case productsRoute:
        return MaterialPageRoute(builder: (_) => ProductsPage(), settings: settings);
      case washListRoute:
        return MaterialPageRoute(builder: (_) => WashListPage(), settings: settings);
      case cartRoute:
        return MaterialPageRoute(builder: (_) => CartPage(), settings: settings);
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsPage(), settings: settings);
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashPage(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_) => NotFoundPage(), settings: settings);
    }
  }
}
