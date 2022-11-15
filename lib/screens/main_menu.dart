// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:hive/hive.dart';
import 'package:meshr_app/screens/bottom_navigation.dart';
import 'package:meshr_app/screens/drawing_page.dart';
import 'package:meshr_app/screens/notification_screen.dart';
import 'package:meshr_app/screens/step-one-3d.dart';
import 'package:meshr_app/screens/step-one-img.dart';
import 'package:meshr_app/screens/step-one-txt.dart';
import 'package:path_provider/path_provider.dart';
import '../data/local-storage.dart';
import '../widgets/menu-card2.dart';
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

  final _myBox = Hive.box('FilesCollection');
  FilesLocalStorage fls = FilesLocalStorage();

  @override
  void initState() {
    // TODO: implement initState
    initClearAppDirectory();
    googleDisplayName = user.displayName!.split(" ")[0];

    print("LOAD"); // Debug purposes
    fls.loadData();

    super.initState();
  }

  void initClearAppDirectory() async {
    print("CLEAR DIRECTORY");
    final directory = await getApplicationDocumentsDirectory();
    deleteFilesExceptExtension('txt', '${directory.path}/');
  }

  void deleteFilesExceptExtension(String suffix, String path) {
    final dir = Directory(path);
    dir.list(recursive: true).listen((file) {
      if (file is File && !file.path.endsWith(suffix)) file.deleteSync();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg-mainmenu.png"),
                fit: BoxFit.cover,
              ),
            ),
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
                  height: 45,
                ),
                MainMenuCard(
                  width: screenWidth,
                  image: "assets/images/book-image.png",
                  imageWidth: 220.0,
                  text: "View Project",
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BottomNavigation(
                              isGallery: true,
                              isClicked: false,
                              isImg: false,
                              img: "",
                            )));
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      Container(
                        width: 70,
                        color: Colors.white,
                        child: Center(
                            child: Text(
                          'Generate',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                        )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MainMenuCard2(
                  width: screenWidth,
                  image: 'assets/images/Txt2Image.png',
                  text: "Text-to-Image",
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GenerateStepOneText()));
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                MainMenuCard2(
                  width: screenWidth,
                  image: "assets/images/Image2Image.png",
                  text: "Image-to-Image",
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GenerateStepOneImage()));
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                MainMenuCard2(
                  width: screenWidth,
                  image: "assets/images/Image2Mesh.png",
                  text: "Image-to-Mesh",
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Currently in development!",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Color(0xFFEFB83C),
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                      elevation: 0,
                    ));
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => GenerateStepOne3D()));
                  },
                ),
                SizedBox(
                  height: 100,
                ),

                // Container(
                //   width: double.infinity,
                //   margin: EdgeInsets.symmetric(horizontal: 30),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       TextButton(
                //           onPressed: () {
                //             Navigator.of(context).push(MaterialPageRoute(
                //                 builder: (context) => GenerateStepOneImage()));
                //           },
                //           child: Text(
                //             "Text -> Image",
                //             style: TextStyle(
                //                 color: Colors.amber,
                //                 fontFamily: 'Roboto',
                //                 fontWeight: FontWeight.w700,
                //                 fontSize: 17),
                //           )),
                //       TextButton(
                //           onPressed: () {},
                //           child: Text(
                //             "Image -> Image",
                //             style: TextStyle(
                //                 color: Colors.amber,
                //                 fontFamily: 'Roboto',
                //                 fontWeight: FontWeight.w700,
                //                 fontSize: 17),
                //           )),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
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
                          isImg: false,
                          img: "",
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
