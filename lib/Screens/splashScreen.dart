import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notebook/Screens/homeScreen.dart';
import 'package:notebook/Screens/loginScreen.dart';
import 'package:notebook/const.dart';
import 'package:notebook/widgets/textWidget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }));
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return LoginScreen();
            }));
          }
          return Container();
        },
      );
    });
    return Scaffold(
      backgroundColor: pryColor,
      body: Center(
          child: CustomTxt(
        color: Colors.white,
      )),
    );
  }
}
