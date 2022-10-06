// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:meshr_app/screens/bottom_navigation.dart';

class GridItem extends StatefulWidget {
  String obj;
  String thumb;
  GridItem({Key? key, required this.obj, required this.thumb}) : super(key: key);

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(11))),
        margin: EdgeInsets.only(top: 35, left: 15, right: 15),
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
                        )));
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 2),
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  widget.obj,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
