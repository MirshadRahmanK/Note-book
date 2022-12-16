import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notebook/Screens/homeScreen.dart';
import 'package:notebook/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController fullnameController = TextEditingController();

TextEditingController loginEmailController = TextEditingController();
TextEditingController loginPasswordController = TextEditingController();

bool signUp = true;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pryColor,
      body: signUp
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextField(
                      controller: loginEmailController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Email',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextField(
                      controller: loginPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Password',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final loginData = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: loginEmailController.text,
                              password: loginPasswordController.text);
                      if (loginData == null) {
                        Fluttertoast.showToast(
                            msg: "Please enter values",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromARGB(255, 255, 254, 254),
                            textColor: Color.fromARGB(255, 5, 5, 5),
                            fontSize: 16.0);
                      } else {
                         final prif = await SharedPreferences.getInstance();
                      prif.setString(
                          'username', loginData.user!.email!.toString());
                      
                        Fluttertoast.showToast(
                            msg: "Login succesfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromARGB(255, 245, 245, 245),
                            textColor: Color.fromARGB(255, 11, 11, 11),
                            fontSize: 16.0);

                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }));
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF020024),
                              const Color(0xFF090979),
                              Color(0xFF00d4ff)
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create new account",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            signUp = false;
                          });
                        },
                        child: Text("Sign up"))
                  ],
                ),
              ],
            )
          //Sign up
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Email',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Password',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextField(
                      controller: fullnameController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Full name',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final signupdetails = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                      final prif = await SharedPreferences.getInstance();
                      prif.setString(
                          'username', signupdetails.user!.email.toString());
                      Fluttertoast.showToast(
                          msg: "Login succesfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color.fromARGB(255, 248, 246, 246),
                          textColor: Color.fromARGB(255, 8, 8, 8),
                          fontSize: 16.0);
                      if (signUp == null) {
                        print("Not dataaaaaaaaaaaa");
                      } else {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }));
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF020024),
                              const Color(0xFF090979),
                              Color(0xFF00d4ff)
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Text(
                          "Sign up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            signUp = true;
                          });
                        },
                        child: Text("Login"))
                  ],
                )
              ],
            ),
    );
  }
}
