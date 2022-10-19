
// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:meshr_app/screens/main_menu.dart';

class GenerateBottomNav extends StatelessWidget {
  GenerateBottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEFB83C),
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                   MaterialPageRoute(builder: (context) => MainMenu()),
                   (Route route) => false);
            },
            child: Container(
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3.8,
                  )),
              child: ImageIcon(
                AssetImage("assets/images/home-icon.png"),
                size: 30.9,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,),
              child: ImageIcon(
                AssetImage("assets/images/help-icon.png"),
                size: 40.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}