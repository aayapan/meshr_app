// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final VoidCallback onPressed;
  const NotificationItem({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
        margin: EdgeInsets.only(top: 20, left: 25, right: 25),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color(0xFFEFB83C),
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Notification/Update Title',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Color(0xFF2D2B2B),
                    ),
                  ),
                  Text(
                    'Date',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_right,
                size: 30,
                color: Colors.grey[800],
              ),
            ],
          ),
        ));
  }
}
