// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:ffi';

import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meshr_app/data/local-storage.dart';
import 'package:meshr_app/screens/drawing_page.dart';
import 'package:meshr_app/screens/step-one-img.dart';
import 'package:meshr_app/widgets/grid-add-button.dart';
import 'package:meshr_app/widgets/grid-item.dart';
import 'package:meshr_app/widgets/list-add-button.dart';
import 'package:meshr_app/widgets/list-item.dart';
import 'package:meshr_app/widgets/user-class.dart';

import '../widgets/grid-item-image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class GalleryImage extends StatefulWidget {
  GalleryImage({
    Key? key,
  }) : super(key: key);

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  bool grid = false;
  int listLength = 2;

  // List objFileNames = [];
  // List thumbFileNames = [];

  final _myBox = Hive.box('FilesCollection');
  FilesLocalStorage fls = FilesLocalStorage();

  @override
  void initState() {
    // if this is the 1st time ever opening the app, create default data
    if (_myBox.get('OBJLIST') == null && _myBox.get('THUMBLIST') == null) {
      print("INIT"); // Debug purposes
      fls.createInitialData();
    } else {
      print("LOAD"); // Debug purposes
      fls.loadData();
    }

    super.initState();
  }
  // getData() async {
  //   final docUser = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('m04TaTo6BhL7okPeMwR2');
  //   final snapshot = await docUser.get();
  //   if (snapshot.exists) {
  //     Map<String, dynamic>? data = snapshot.data();
  //     paths = data!['paths'];
  //     filenames = data['filenames']; // <-- The value you want to retrieve.
  //     // Call setState if needed.
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2D2B2B),
        title: Text(
          "Gallery",
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 30,
            color: Colors.white,
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
      body: Column(
        children: [
          Container(
            height: 1.2,
            color: Colors.white,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Color(0xFF2D2B2B),
                  height: double.infinity,
                ),
                Container(
                    // height: 300, //570 if no navbar
                    color: Color(0xFF2D2B2B),
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(fls.imageFileNames!.length + 1,
                          (index) {
                        return index == fls.imageFileNames!.length
                            ? GridAddButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          color: Color(0xFFEFB83C),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                leading: Icon(
                                                    Icons.text_format,
                                                    size: 40,
                                                    color: Color(0xFF2D2B2B)),
                                                title: Text(
                                                  'Text-to-Image',
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w300,
                                                    color: Color(0xFF2D2B2B),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              GenerateStepOneImage()));
                                                },
                                              ),
                                              ListTile(
                                                leading: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 7),
                                                    child: Icon(
                                                      Icons.image_search,
                                                      size: 30,
                                                      color: Color(0xFF2D2B2B),
                                                    )),
                                                title: Text(
                                                  'Image-to-Image',
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w300,
                                                    color: Color(0xFF2D2B2B),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DrawingPage()));
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                              )
                            : GridItemImage(
                                img: fls.imageFileNames![index],
                              );
                      }),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
