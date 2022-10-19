// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import 'package:meshr_app/screens/bottom_navigation.dart';

class ListItem extends StatefulWidget {
  String obj;
  String thumb;
  ListItem({Key? key, required this.obj, required this.thumb}) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(11))),
        margin: EdgeInsets.only(top: 35, left: 25, right: 25),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Color(0xFFEFB83C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11.0))),
          onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BottomNavigation(
                          isGallery: true,
                          isClicked: true,
                          isImg: false,
                        )));
          },
          child: Container(
            height: 90.0,
            width: double.infinity,
            child: Row(children: [
              Container(
                margin: EdgeInsets.only(left: 5, right: 10),
                color: Colors.grey,
                width: 80,
                height: 80,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.obj,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Date",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
