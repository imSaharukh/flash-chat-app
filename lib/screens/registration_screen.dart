import 'dart:math';

import 'package:flutter/material.dart';
import 'package:chatapp_x/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp_x/constants.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'regscreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool spinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value.trim();
                },
                decoration:
                    kInputDecoration.copyWith(hintText: 'Enter Your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration:
                    kInputDecoration.copyWith(hintText: 'Enter Your Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colorr: Colors.lightBlueAccent,
                text: 'Register',
                onpressed: () async {
                  setState(() {
                    spinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    setState(() {
                      spinner = false;
                    });
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    } else {
                      throw e;
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}