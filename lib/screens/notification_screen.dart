// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meshr_app/screens/notification_view.dart';
import 'package:meshr_app/widgets/notification-item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF2D2B2B),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: ImageIcon(AssetImage("assets/images/back-icon.png")),
          iconSize: 40.0,
          color: Color(0xFFEFB83C),
        ),
      ),
      body: ListView(
        children: List.generate(3, (index) {
          return NotificationItem(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NotificationView(
                    notificationTitle: 'Notif Title',
                    notificationSubTitle: 'Sub Title'),
              ));
            },
          );
        }),
      ),
    );
  }
}
