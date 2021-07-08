import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_petrol_station/Screens/Dashboard.dart';

import 'package:flutter_petrol_station/constants.dart';

class Login extends StatefulWidget {
  static String id = 'login';
  //final User user; // change class name

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;

  String email, password, emailE = ' ', passE = ' ', error = 'Enter some text';
  Color colorE = Colors.blueAccent, colorP = Colors.blueAccent;
  int passError = -1, emailError = -1, loggedIn = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Image(
                      image: AssetImage("assets/pic.png"),
                      width: 280,height: 280,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your Email',
                            suffixIcon: Icon(Icons.email),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorE),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorE, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              colorE = Colors.blueAccent;
                            });
                            email = value;
                          },
                        ),
                        SizedBox(
                          height: 1.0,
                        ),
                        Text(
                          emailError == 1 ? 'Enter some text' : '',
                          style: TextStyle(color: colorE),
                        ),
                        TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your password',
                            suffixIcon: Icon(Icons.remove_red_eye),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorP),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorP, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              colorP = Colors.blueAccent;
                            });
                            password = value;
                          },
                        ),
                        SizedBox(
                          height: 1.0,
                        ),
                        Text(
                          passError == 1 ? 'Enter some text' : '',
                          style: TextStyle(color: colorP),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueAccent),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (email == null) {
                              print('email empty');
                              setState(() {
                                emailError = 1;
                                colorE = Colors.red;
                                emailE = 'Enter some text';
                                print('color Email:');
                                print(colorE.value);
                                print(emailError);
                              });
                            }
                            if (password == null) {
                              print('password empty');
                              setState(() {
                                passError = 1;
                                colorP = Colors.red;
                                passE = 'Enter some text';
                                print('color password:');
                                print(colorP.value);
                                print(passError);
                              });
                            }
                            if (email != null && password != null) {
                              if (email.isEmpty) {
                                setState(() {
                                  emailError = 1;
                                  colorE = Colors.red;
                                  emailE = 'Enter some text';
                                  print('color Email:');
                                  print(colorE.value);
                                  print(emailError);
                                });
                              }
                              if (password.isEmpty) {
                                setState(() {
                                  passError = 1;
                                  colorP = Colors.red;
                                  passE = 'Enter some text';
                                  print('color password:');
                                  print(colorP.value);
                                  print(passError);
                                });
                              }
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);

                                if (user != null) {
                                  //Navigator.pushNamed(context, Containers.id);
                                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                                  setState(() {
                                    emailError = 0;
                                    passError = 0;
                                    colorE = Colors.blueAccent;
                                    colorP = Colors.blueAccent;
                                  });
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}