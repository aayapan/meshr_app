// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:meshr_app/screens/step-one-txt.dart';

class ListAddButton extends StatelessWidget {
  VoidCallback onPressed;
  ListAddButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(11))),
        margin: EdgeInsets.only(top: 35, left: 25, right: 25),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color(0xFFEFB83C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11.0))),
          onPressed: onPressed,
          child: Container(
            height: 90.0,
            width: screenWidth,
            child: Center(
              child: Text(
                "+",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w900,
                  fontSize: 48,
                ),
              ),
            ),
          ),
        ));
  }
}
