// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:meshr_app/screens/view-output-img.dart';

class OutputItem extends StatefulWidget {
  VoidCallback onPressed;
  String imageUrl;
  OutputItem({Key? key, required this.onPressed, required this.imageUrl})
      : super(key: key);

  @override
  State<OutputItem> createState() => _OutputItemState();
}

class _OutputItemState extends State<OutputItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(11)),
            border: Border.all(width: 4, color: Colors.black)),
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
          child: Center(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(11)),), 
              child: Image.network(
                widget.imageUrl,
                width: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ));
  }
}
