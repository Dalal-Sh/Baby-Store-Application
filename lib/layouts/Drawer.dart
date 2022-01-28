import 'package:baby_store_app/localization/language_constants.dart';
import 'package:baby_store_app/providers/auth.dart';
import 'package:baby_store_app/providers/preferences.dart';
import 'package:baby_store_app/router/route_constants.dart';
import 'package:provider/provider.dart';

import '../pages/about_page.dart';
import '../pages/cart.dart';
import '../pages/home.dart';
import '../pages/products.dart';
import '../pages/settings.dart';
import '../pages/washlist.dart';
import 'package:flutter/material.dart';


class BabyDrawer extends StatelessWidget {
  final String title;

  const BabyDrawer({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,//20.0,
      child:  Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFff6f96),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Column(children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/avatar.png'),
                      radius: 40.0,
                    ),
                    Text("${Provider.of<Auth>(context).userName}", style: TextStyle(color: Colors.white, fontFamily:'Baby'),)
                  ],),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.pages),
              title: Text(getTranslated(context, 'home_page')),
              onTap: () => {
                Navigator.pushNamed(context, homeRoute)
              },
            ),

            ListTile(
              leading: Icon(Icons.message),
              title: Text(getTranslated(context, 'about_page')),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return AboutPage();
                }))
              },
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text(getTranslated(context, 'products_page')),
              onTap: () => {
                Navigator.pushNamed(context, productsRoute)

              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text(getTranslated(context, 'washList_page')),
              onTap: () => {
                Navigator.pushNamed(context, washListRoute)
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(getTranslated(context, 'cart_page')),
              onTap: () => {
                Navigator.pushNamed(context, cartRoute)
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(getTranslated(context, 'settings_page')),
              onTap: () => {
                Navigator.pushNamed(context, settingsRoute)

              },
            ),
          ],
        )
      ),
    );
  }
}




// import 'package:baby_store_app/localization/language_constants.dart';
// import 'package:baby_store_app/providers/auth.dart';
// import 'package:baby_store_app/router/route_constants.dart';
// import 'package:provider/provider.dart';
//
// import '../pages/about_page.dart';
// import '../pages/cart.dart';
// import '../pages/home.dart';
// import '../pages/products.dart';
// import '../pages/settings.dart';
// import '../pages/washlist.dart';
// import 'package:flutter/material.dart';
//
// class BabyDrawer extends StatelessWidget {
//   const BabyDrawer({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return new SizedBox(
//       width: MediaQuery.of(context).size.width * 0.85,//20.0,
//       child:  Drawer(
//         child:
//         Consumer<Auth>(
//             builder: (ctx, auth, _){
//               print(auth.userName);
//               return    ListView(
//                 padding: EdgeInsets.zero,
//                 children: <Widget>[
//                   DrawerHeader(
//                     decoration: BoxDecoration(
//                       color: Color(0xFFff6f96),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: Center(
//                         child: Column(children: [
//                           CircleAvatar(
//                             backgroundImage: AssetImage('images/avatar.png'),
//                             radius: 40.0,
//                           ),
//                           Text(auth.userEmail, style: TextStyle(color: Colors.white, fontFamily:'Baby'),)
//                         ],),
//                       ),
//                     ),
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.pages),
//                     title: Text(getTranslated(context, 'home_page')),
//                     onTap: () => {
//                       Navigator.pushNamed(context, homeRoute)
//                     },
//                   ),
//
//                   ListTile(
//                     leading: Icon(Icons.message),
//                     title: Text(getTranslated(context, 'about_page')),
//                     onTap: () => {
//                       Navigator.of(context).push(MaterialPageRoute(builder: (context){
//                         return AboutPage();
//                       }))
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.card_giftcard),
//                     title: Text(getTranslated(context, 'products_page')),
//                     onTap: () => {
//                       Navigator.pushNamed(context, productsRoute)
//
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.favorite),
//                     title: Text(getTranslated(context, 'washList_page')),
//                     onTap: () => {
//                       Navigator.pushNamed(context, washListRoute)
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.shopping_cart),
//                     title: Text(getTranslated(context, 'cart_page')),
//                     onTap: () => {
//                       Navigator.pushNamed(context, cartRoute)
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.settings),
//                     title: Text(getTranslated(context, 'settings_page')),
//                     onTap: () => {
//                       Navigator.pushNamed(context, settingsRoute)
//
//                     },
//                   ),
//                 ],
//               );
//             }
//         ),
//
//
//       ),
//     );
//   }
// }