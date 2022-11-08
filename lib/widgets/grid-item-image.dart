// ignore_for_file: prefer_const_constructors

import 'dart:io';

import "package:flutter/material.dart";
import 'package:meshr_app/screens/bottom_navigation.dart';

class GridItemImage extends StatefulWidget {
  String img;
  VoidCallback onPressed;
  GridItemImage({
    Key? key,
    required this.img,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<GridItemImage> createState() => _GridItemImageState();
}

class _GridItemImageState extends State<GridItemImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(11))),
        margin: EdgeInsets.only(top: 35, left: 15, right: 15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              primary: Colors.white,
              onPrimary: Color(0xFFEFB83C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11.0))),
          onPressed: widget.onPressed,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(11))),
            child: Center(
                child: Image.file(
              File(widget.img),
              width: 300,
              fit: BoxFit.fitWidth,
            )),
          ),
        ));
  }
}
