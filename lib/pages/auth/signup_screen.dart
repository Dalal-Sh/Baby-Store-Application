import 'package:auto_size_text/auto_size_text.dart';
import 'package:baby_store_app/localization/language_constants.dart';
import 'package:baby_store_app/router/route_constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';
import '../../utils/http_exception.dart';
import '../home.dart';

class signupPage extends StatefulWidget {
  @override
  _signupPageState createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {'name': '' , 'email': '', 'password': '', 'password': ''};
  TextEditingController _passwordController = new TextEditingController();


  Future _submit() async {

    if (!_formKey.currentState.validate()) {
      //invalid
      return;
    }
    _formKey.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false)
          .signUp(_authData['name'], _authData['email'], _authData['password']);
      // var userName =  Provider.of<Auth>(context).userName;
      // print(userName);
      Navigator.pushNamed(context, loginRoute);

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Stack(
              children: <Widget>[
                Padding(
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
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: AutoSizeText("${getTranslated(context, 'sign_in')}", style: TextStyle(fontFamily: 'Baby',color: Colors.white, fontSize: 30),),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Name",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                              )),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Name is required';
                                            }
                                          },
                                          onSaved: (value) {
                                            _authData['name'] = value;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Email",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                              )),
                                          validator: (value) {
                                            if (value.isEmpty || !value.contains('@')) {
                                              return 'Invalid email';
                                            }
                                          },
                                          onSaved: (value) {
                                            _authData['email'] = value;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Password",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        TextFormField(
                                          obscureText: true,
                                          controller: _passwordController,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.vpn_key,
                                                color: Colors.white,
                                              )),
                                          validator: (value) {
                                            if (value.isEmpty || value.length < 5) {
                                              return 'Password is to Short';
                                            }
                                          },
                                          onSaved: (value) {
                                            _authData['password'] = value;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Confirm Password",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        TextFormField(
                                          obscureText: true,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.vpn_key,
                                                color: Colors.white,
                                              )),
                                          validator: (value) {
                                            if (value != _passwordController.text) {
                                              return 'Password doesnot match';
                                            }
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
                                              Navigator.pushNamed(context, loginRoute);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(top: 20),
                                              child: Center(
                                                child: Text(
                                                  "Login?",
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
                                        ),
                                      ],
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
              ]
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
