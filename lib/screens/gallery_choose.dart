// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:meshr_app/screens/gallery_3d.dart';
import 'package:meshr_app/screens/gallery_image.dart';

class GalleryMain extends StatelessWidget {
  int imgLength;
  int objLength;
  GalleryMain({Key? key, required this.imgLength, required this.objLength,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Color(0xFF2D2B2B),
                  height: double.infinity,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GalleryImage()));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white,),
                            ),
                            SizedBox(height: 7,),
                            Text(
                              "Images",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 7,),
                            Text(
                              imgLength.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Gallery3D()));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white,),
                              
                            ),
                            SizedBox(height: 7,),
                            Text(
                              "3D Models",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 7,),
                            Text(
                              objLength.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
