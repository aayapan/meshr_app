// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:meshr_app/screens/main_menu.dart';

class CustomNavBar extends StatelessWidget {
  
  PageController controller;
  int currentIndex;
  bool isGalleryView;
  CustomNavBar(
      {Key? key,
      required this.controller,
      required this.currentIndex,
      required this.isGalleryView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            currentIndex: currentIndex,
            selectedItemColor: Color(0xFFEFB83C),
            unselectedFontSize: 12,
            selectedFontSize: 12,
            onTap: (index) {
              // controller.jumpToPage(index);
              controller.animateToPage(index, duration: Duration(milliseconds: 150), curve: Curves.easeInOut);
            },
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/settings-icon.png"),
                    size: 32,
                  ),
                  label: "Settings"),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/images/gallery-icon.png"),
                    size: 32,
                  ),
                  label: "Gallery"),
            ],
            type: BottomNavigationBarType.fixed,
          ),
          Positioned(
              top: -30,
              child: Container(
                // padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFFEFB83C),
                      width: 5,
                    )),
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => MainMenu()),
                        (Route route) => false);
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => mainMenu()));
                  },
                  fillColor: Colors.white,
                  padding: EdgeInsets.all(5.0),
                  shape: CircleBorder(),
                  child: ImageIcon(
                    AssetImage("assets/images/home-icon.png"),
                    size: 50.0,
                    color: Color(0xFFEFB83C),
                  ),
                ),
              )),
          // Positioned(
          //   top: 0,
          //   right: 15,
          //   child: FloatingActionButton(
          //     elevation: 0,
          //     backgroundColor: Colors.transparent,
          //     onPressed: () {},
          //     child: ImageIcon(
          //       AssetImage("assets/images/help-icon.png"),
          //       size: double.infinity,
          //       color: Color(0xFFEFB83C),
          //     ),
          //   ),
          // )
        ]);
  }
}
