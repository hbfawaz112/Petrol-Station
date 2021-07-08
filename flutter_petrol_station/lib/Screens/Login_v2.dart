import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../constants.dart';
import 'Dashboard.dart';

class Loginv2 extends StatefulWidget {
  static String id = 'login';
  //final User user; // change class name

  @override
  _Loginv2State createState() => _Loginv2State();
}

class _Loginv2State extends State<Loginv2> {
  final _auth = FirebaseAuth.instance;

  String email, password, emailE = ' ', passE = ' ', error = 'Enter some text';
  Color colorE = Colors.blueAccent, colorP = Colors.blueAccent;
  int passError = -1, emailError = -1, loggedIn = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body:  Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Image(
                        image: AssetImage("assets/fuel.png"),
                        width: 90,
                        height: 90,
                      ),
                      SizedBox(height:20),
                   
                  
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
                        SizedBox(height:13),
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
                              fontSize: 22
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
                                  Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Dashboard()),
                                      );
                                  setState(() {
                                    emailError = 0;
                                    passError = 0;
                                    colorE = Colors.blueAccent;
                                    colorP = Colors.blueAccent;
                                  });
                                }
                                else{
                                  // verficiation for wrong password
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
               
              )));
            
        
    
  }
}
