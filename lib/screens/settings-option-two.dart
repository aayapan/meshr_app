// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class SettingsOptionTwo extends StatefulWidget {
  final bool isClicked;
  const SettingsOptionTwo({Key? key, required this.isClicked})
      : super(key: key);

  @override
  State<SettingsOptionTwo> createState() => _SettingsOptionTwoState();
}

class _SettingsOptionTwoState extends State<SettingsOptionTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: widget.isClicked ? Colors.white : Color(0xFF2D2B2B),
        title: Text(
          "Settings",
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 30,
            color: widget.isClicked ? Color(0xFF2D2B2B) : Colors.white,
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
      ),
      body: Container(
        color: widget.isClicked ? Colors.white : Color(0xFF2D2B2B),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 50,
                  child: Text(
                    "Settings 2",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color:
                          widget.isClicked ? Color(0xFF2D2B2B) : Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 0.5,
                  color: widget.isClicked ? Color(0xFF2D2B2B) : Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 50,
                  child: Text(
                    "Settings 2",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color:
                          widget.isClicked ? Color(0xFF2D2B2B) : Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 0.5,
                  color: widget.isClicked ? Color(0xFF2D2B2B) : Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: 50,
                  child: Text(
                    "Settings 2",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color:
                          widget.isClicked ? Color(0xFF2D2B2B) : Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 0.5,
                  color: widget.isClicked ? Color(0xFF2D2B2B) : Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
