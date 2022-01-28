import 'dart:io';

import 'package:baby_store_app/classes/language.dart';
import 'package:baby_store_app/providers/auth.dart';
import 'package:baby_store_app/router/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import '../../localization/language_constants.dart';
import '../home_page.dart';



class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {'email': '', 'password': ''};

  Future _submit() async {

    if (!_formKey.currentState.validate()) {
      //invalid
      return;
    }
    _formKey.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(_authData['email'], _authData['password']);
          Navigator.pushNamed(context, homeRoute);

      // var userName =  Provider.of<Auth>(context).userName;
      // print(userName);
    } on HttpException catch (e) {
      var errorMessage = 'Authentication Failed';
      if (e.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Invalid email';
        _showerrorDialog(errorMessage);
      } else if (e.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'This email not found';
        _showerrorDialog(errorMessage);
      } else if (e.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid Password';
        _showerrorDialog(errorMessage);
      }
    } catch (error) {
      print(error);
      var errorMessage = 'Please try again later';
      _showerrorDialog(errorMessage);
    }
  }

  void _showSuccessDialog() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: DottedBorder(
            dashPattern: [8, 7],
            color: Colors.amber,
            radius: Radius.circular(12),
            strokeWidth: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.lightBlueAccent,

                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: AutoSizeText("${getTranslated(context, 'sign_in')}", style: TextStyle(fontFamily: 'Baby',color: Colors.white, fontSize: 30),),
                        ),
                        Form(
                          key: _formKey,
                          child: Container(
                            padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${getTranslated(context, 'email')}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                      autofocus: false,
                                      style: TextStyle(fontSize: 20.0, color: Color(0xFFbdc6cf), fontFamily: 'Baby'),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: getTranslated(context, 'email'),
                                        contentPadding:
                                        const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 8.0, top: 8.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(25.7),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(25.7),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty || !value.contains('@')) {
                                          return 'Invalid email';
                                        }
                                      },
                                      onSaved: (value) {
                                        _authData['email'] = value;
                                      }
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${getTranslated(context, 'password')}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    autofocus: false,
                                    style: TextStyle(fontSize: 20.0, color: Color(0xFFbdc6cf), fontFamily: 'Baby'),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: getTranslated(context, 'password'),
                                      contentPadding:
                                      const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 8.0, top: 8.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(25.7),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(25.7),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 5) {
                                        return 'Password is to Short';
                                      }
                                    },
                                    onSaved: (value) {
                                      _authData['password'] = value;
                                    },
                                  ),
                                  Center(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 15),
                                      width: 140,
                                      child: ElevatedButton(
                                          onPressed: (){
                                            _submit();
                                          },
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.pink)),
                                          child: AutoSizeText("${getTranslated(context, 'submit_info')}",
                                            style: TextStyle(color: Colors.white),)),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, signupRoute);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Center(
                                          child: Text(
                                            "Create Account ?",
                                            style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'Baby'
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),),
            ),
          ),
        ),
      ),
    );
  }
  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An Error Occurs',
          style: TextStyle(color: Colors.blue),
        ),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
