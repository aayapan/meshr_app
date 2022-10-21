
// ignore_for_file: unnecessary_const, prefer_const_constructors_in_immutables, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meshr_app/screens/login_screen.dart';
import 'package:meshr_app/screens/main_menu.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
            print(' =====> MAIN MENU');
            print(snapshot.connectionState.toString());
            return MainMenu();
          }
          else if (snapshot.hasError) {
            print("ERROR");
            return const Center(child: const Text('Something Went Wrong!',style: TextStyle(fontFamily: 'Roboto', fontSize: 20, fontWeight: FontWeight.w700),),);
          }
        else {
          print("LOGIN SCREEN");
          return LoginScreen();
        }
      },
    ));
  }
}
