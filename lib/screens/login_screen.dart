// ignore_for_file: prefer_const_constructors, unnecessary_new, unnecessary_brace_in_string_interps, avoid_print, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meshr_app/main.dart';
import 'package:meshr_app/provider/google_sign_in.dart';
import 'package:meshr_app/screens/main_menu.dart';
import 'package:meshr_app/screens/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email, _password;

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future signIn() async {
      try {
        if (_password == null || _email == null || _email == "" || _password == "") {
          print("Empty");
          throw FirebaseAuthException(
              code: "Login Error",
              message: "Please complete the Login Form.");
        }
      } on FirebaseAuthException catch (e) {
        print(e.message);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message!),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
        return;
      }

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (contex) => Center(child: CircularProgressIndicator()));
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email!, password: _password!);
      } on FirebaseAuthException catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message!),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg-login.png'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 40),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: -100,
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Image(
                          image: AssetImage('assets/images/LogoCircle.png'),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          "Login Account",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                height: 24,
                                child: TextField(
                                  controller: _emailController,
                                  onChanged: (value) {
                                    _email = _emailController.text.trim();
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 12),
                                      hintText: 'email@example.com',
                                      border: UnderlineInputBorder()),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Password',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                height: 24,
                                child: TextField(
                                  controller: _passwordController,
                                  onChanged: (value) {
                                    _password = _passwordController.text.trim();
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 12),
                                    hintText: '********',
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xFFEFB83C))),
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              onPressed: () {
                                signIn().then((value) {
                                  print("Signed In");
                                });
                              },
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                width: 40,
                                color: Colors.white,
                                child: Center(child: Text('or')),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                side: MaterialStateProperty.all(BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                    style: BorderStyle.solid))),
                            onPressed: () {
                              final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.googleLogin();
                            },
                            label: Text('Sign In with Google',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15)),
                            icon: FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            TextButton(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        Color(0xFFEFB83C))),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return new RegisterScreen();
                                  }));
                                },
                                child: Text(
                                  'Sign Up!',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
