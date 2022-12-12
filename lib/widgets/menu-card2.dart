// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class MainMenuCard2 extends StatefulWidget {
  final String text;
  final String image;
  final double width;
  final VoidCallback onPressed;
  const MainMenuCard2(
      {Key? key,
      required this.width,
      required this.image,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  State<MainMenuCard2> createState() => _MainMenuCard2State();
}

class _MainMenuCard2State extends State<MainMenuCard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(11)),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 1.0,
                offset: Offset(0.0, 1.0)),
          ],
          border: Border.all(width: 1, color: Colors.black)),
      margin: EdgeInsets.only(left: 30, right: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0))),
        onPressed: widget.onPressed,
        child: Container(
          padding: EdgeInsets.zero,
          height: 130,
          width: widget.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                    color: Color(0xFFEFB83C),
                    border: Border.all(width: 1, color: Colors.black)),
                width: 180,
                height: double.infinity,
                child: Center(
                    child: Text(
                  widget.text,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(0xFF2D2B2B)),
                )),
              ),
              Expanded(
                child: Container(
                  child: Center(
                      child: Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                    width: 120,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
