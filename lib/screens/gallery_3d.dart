// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:ffi';

import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meshr_app/data/local-storage.dart';
import 'package:meshr_app/screens/step-one-3d.dart';
import 'package:meshr_app/widgets/grid-add-button.dart';
import 'package:meshr_app/widgets/grid-item.dart';
import 'package:meshr_app/widgets/list-add-button.dart';
import 'package:meshr_app/widgets/list-item.dart';
import 'package:meshr_app/widgets/user-class.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Gallery3D extends StatefulWidget {
  Gallery3D({
    Key? key,
  }) : super(key: key);

  @override
  State<Gallery3D> createState() => _Gallery3DState();
}

class _Gallery3DState extends State<Gallery3D> {
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
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (grid == false) {
                  grid = true;
                } else {
                  grid = false;
                }
              });
            },
            icon: grid
                ? ImageIcon(AssetImage("assets/images/list-view-icon.png"))
                : ImageIcon(AssetImage("assets/images/grid-view-icon.png")),
            iconSize: 40.0,
            color: Color(0xFFEFB83C),
            splashColor: Colors.white,
            splashRadius: 120,
          ),
        ],
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
                    child: grid
                        ? GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(fls.objFileNames!.length + 1,
                                (index) {
                              return index == fls.objFileNames!.length
                                  ? GridAddButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GenerateStepOne3D()));
                                      },
                                    )
                                  : GridItem(
                                      obj: fls.objFileNames![index],
                                      thumb: fls.thumbFileNames![index],
                                    );
                            }),
                          )
                        : ListView(
                            children: List.generate(fls.objFileNames!.length + 1,
                                (index) {
                              return index ==
                                      fls.objFileNames!
                                          .length // Paths and Filenames should always have the same length
                                  ? ListAddButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GenerateStepOne3D()));
                                      },
                                    )
                                  : ListItem(
                                      obj: fls.objFileNames![index],
                                      thumb: fls.thumbFileNames![index],
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
