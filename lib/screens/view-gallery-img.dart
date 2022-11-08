// ignore_for_file: prefer_const_constructors

import 'dart:io';

import "package:flutter/material.dart";
import 'package:hive/hive.dart';
import 'package:meshr_app/data/local-storage.dart';
import 'package:meshr_app/screens/gallery_image.dart';
import 'package:meshr_app/screens/step-one-img.dart';
import 'package:meshr_app/screens/step-one-txt.dart';
import 'package:path/path.dart';

class ViewGalleryImg extends StatelessWidget {
  String img;
  ViewGalleryImg({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _myBox = Hive.box('FilesCollection');
    FilesLocalStorage fls = FilesLocalStorage();

    Future<void> deleteFile(File file) async {
      try {
        if (await file.exists()) {
          fls.loadData();
          fls.imageFileNames.remove(img);
          fls.updateData();
          await file.delete().then((value) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Image Deleted!",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Color(0xFFEFB83C),
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
              elevation: 0,
            ));
            Navigator.pop(context, true);
          });
        }
      } catch (e) {
        print(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2D2B2B),
        title: Text(
          basename(img),
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Color(0xFFEFB83C),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: ImageIcon(AssetImage("assets/images/back-icon.png")),
          iconSize: 40.0,
          color: Color(0xFFEFB83C),
        ),
        actions: [
          
          IconButton(
            onPressed: () async {
              await deleteFile(File(img));
            },
            icon: ImageIcon(
              AssetImage("assets/images/trash-icon.png"),
            ),
            iconSize: 40.0,
            color: Color(0xFFEFB83C),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFF2D2B2B),
        child: Column(
          children: [
            Container(
              color: Color(0xFFEFB83C),
              height: 2,
              width: double.infinity,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.red,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width,
                    child: Image.file(
                      File(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11))),
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFFEFB83C),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11.0))),
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
                                        leading: Icon(Icons.text_format,
                                            size: 40, color: Color(0xFF2D2B2B)),
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
                                                      GenerateStepOneText()));
                                        },
                                      ),
                                      ListTile(
                                        leading: Container(
                                            margin: EdgeInsets.only(left: 7),
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
                                                      GenerateStepOneImage()));
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          height: 33,
                          width: 60,
                          child: Center(
                            child: Text(
                              "+",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
