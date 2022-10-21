// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ImageHelp extends StatelessWidget {
  String header;
  String footer;
  ImageHelp({
    Key? key, required this.header, required this.footer
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(elevation: 0, backgroundColor: Color(0xFFEFB83C), leading: 
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ImageIcon(AssetImage("assets/images/back-icon.png")),
            iconSize: 40.0,
            color: Colors.white,
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(0xFFEFB83C),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 52,),
                Text(
                  header,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),

                Text(
                  footer,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
