import 'package:baby_store_app/classes/language.dart';
import 'package:baby_store_app/pages/splash_screen.dart';
import 'package:baby_store_app/providers/auth.dart';
import 'package:baby_store_app/router/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import '../localization/language_constants.dart';
import 'auth/login_screen.dart';
import 'home.dart';



class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();


  void _showSuccessDialog() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: Auth(),
        child: Consumer<Auth>(
            builder: (ctx, auth, _){
              print(auth.isAuth);
             return auth.isAuth
                  ? HomePage()
                  : FutureBuilder(
                     future: auth.tryautoLogin(),builder: (ctx, snapshot) =>
                     snapshot.connectionState == ConnectionState.waiting
                  ? SplashPage()
                  : LoginPage(),
              );
            }
        ),
      ),
    );
  }
}
