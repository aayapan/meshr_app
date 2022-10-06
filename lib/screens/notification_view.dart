// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  final String notificationTitle;
  final String notificationSubTitle;
  const NotificationView({Key? key, required this.notificationTitle, required this.notificationSubTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFEFB83C),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: ImageIcon(AssetImage("assets/images/back-icon.png")),
          iconSize: 40.0,
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFEFB83C),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationTitle,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 48.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    letterSpacing: -1,
                  ),
                ),
                Text(
                  notificationSubTitle,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 24.0,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                    letterSpacing: -1,
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}