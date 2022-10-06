// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:meshr_app/screens/bottom_navigation.dart';
import 'package:meshr_app/screens/notification_screen.dart';
import 'package:meshr_app/screens/step-one.dart';
import '../widgets/menu_card.dart';

class MainMenu extends StatefulWidget {
  MainMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool selected = true;
  final user = FirebaseAuth.instance.currentUser!;
  String? googleDisplayName;

  @override
  void initState() {
    // TODO: implement initState
    googleDisplayName = user.displayName!.split(" ")[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "MESHR",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 45,
                        color: Color(0xFFEFB83C),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NotificationScreen()));
                      },
                      icon: ImageIcon(
                        AssetImage("assets/images/bell-icon.png"),
                      ),
                      iconSize: 45,
                      color: Color(0xFFEFB83C),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30),
                width: screenWidth,
                child: Text(
                  "Hi, ${googleDisplayName!}",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 32,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              SizedBox(
                height: 85,
              ),
              MainMenuCard(
                width: screenWidth,
                image: "assets/images/book-image.png",
                imageWidth: 285.0,
                text: "View Project",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BottomNavigation(
                            isGallery: true,
                            isClicked: false,
                          )));
                },
              ),
              SizedBox(
                height: 70,
              ),
              MainMenuCard(
                width: screenWidth,
                image: "assets/images/cube-image.png",
                imageWidth: 176.0,
                text: "Generate",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GenerateStepOne()));
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BottomNavigation(
                          isGallery: false,
                          isClicked: false,
                        )));
              },
              icon: ImageIcon(AssetImage("assets/images/settings-icon.png")),
              color: Color(0xFFEFB83C),
              iconSize: 45,
            ),
            IconButton(
              onPressed: () {},
              icon: ImageIcon(AssetImage("assets/images/help-icon.png")),
              color: Color(0xFFEFB83C),
              iconSize: 40,
            ),
          ],
        ),
      ),
    );
  }
}
