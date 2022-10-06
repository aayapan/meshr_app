// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";



class ViewGallery extends StatelessWidget {
  const ViewGallery({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "TITLE",
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Color(0xFFEFB83C),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: ImageIcon(AssetImage("assets/images/back-icon.png")),
          iconSize: 40.0,
          color: Color(0xFFEFB83C),
        ),
        actions: [
          IconButton(
          onPressed: () {},
          icon: ImageIcon(AssetImage("assets/images/trash-icon.png")),
          iconSize: 40.0,
          color: Color(0xFFEFB83C),
        ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              // THIS IS WHERE WE CONTAIN THE 3D OBJECT VIEWER
              height: 534, //570 if no navbar
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
