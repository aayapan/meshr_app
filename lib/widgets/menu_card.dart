// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class MainMenuCard extends StatefulWidget {
  final String text;
  final String image;
  final double width;
  final double imageWidth;
  final VoidCallback onPressed;
  const MainMenuCard(
      {Key? key,
      required this.width,
      required this.image,
      required this.imageWidth,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  State<MainMenuCard> createState() => _MainMenuCardState();
}

class _MainMenuCardState extends State<MainMenuCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(11)),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 1.0,
                offset: Offset(0.0, 3.0)),
          ]),
      margin: EdgeInsets.only(left: 30, right: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color(0xFFEFB83C),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0))),
        onPressed: widget.onPressed,
        child: Container(
          padding: EdgeInsets.zero,
          height: 130,
          width: widget.width,
          child: Stack(
            alignment: Alignment.topRight,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: -60,
                  right: -17,
                  width: widget.imageWidth,
                  child: GestureDetector(
                      onTap: widget.onPressed,
                      child: Image.asset(widget.image))),
              Positioned(
                bottom: 10,
                left: 2,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Color(0xFF2D2B2B),
                    fontFamily: "Roboto",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
