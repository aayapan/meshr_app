// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class ViewGalleryImg extends StatelessWidget {
  const ViewGalleryImg({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "TITLE",
            style: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Color(0xFFEFB83C),
            ),
          ),
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
              onPressed: () {},
              icon: ImageIcon(AssetImage("assets/images/gdrive-icon.png")),
              iconSize: 40.0,
              color: Color(0xFFEFB83C),
            ),
            IconButton(
              onPressed: () {},
              icon: ImageIcon(AssetImage("assets/images/trash-icon.png"),),
              iconSize: 40.0,
              color: Color(0xFFEFB83C),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(color: Color(0xFFEFB83C), height: 2, width: double.infinity,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.red,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width,
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
                        onPressed: () {},
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
