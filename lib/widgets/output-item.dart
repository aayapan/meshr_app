// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:meshr_app/screens/view-output.dart';

class OutputItem extends StatefulWidget {
  OutputItem({
    Key? key,
  }) : super(key: key);

  @override
  State<OutputItem> createState() => _OutputItemState();
}

class _OutputItemState extends State<OutputItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            border: Border.all(width: 4, color: Colors.black)),
        margin: EdgeInsets.only(top: 35, left: 15, right: 15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Color(0xFFEFB83C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11.0))),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewOutput()));
          },
          child: Center(
            child: Text(
              "Image",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ));
  }
}