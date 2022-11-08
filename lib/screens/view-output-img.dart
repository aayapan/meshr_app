// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meshr_app/data/local-storage.dart';
import 'package:meshr_app/widgets/output-footer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ViewOutputImage extends StatelessWidget {
  String imageUrl;
  ViewOutputImage({Key? key, required this.imageUrl}) : super(key: key);

  final _myBox = Hive.box('FilesCollection');
  FilesLocalStorage fls = FilesLocalStorage();

  Future<File> saveImagePermanently(String url) async {
    final response = await http.get(Uri.parse(url));
    final directory = await getExternalStorageDirectory();

    DateTime date = DateTime.now();
    final image = File('${directory?.path}/${date.toString()}.jpg');
    image.writeAsBytesSync(response.bodyBytes);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
            onPressed: () async {
              // SAVE TO GALLERY FUNCTION
              final img = await saveImagePermanently(imageUrl);
              fls.loadData();
              fls.imageFileNames.add(img.path);
              fls.updateData();

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Image Saved!",
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
            },
            icon: ImageIcon(AssetImage("assets/images/save-icon.png")),
            iconSize: 40.0,
            color: Color(0xFFEFB83C),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
      bottomNavigationBar: OutputBottomNav(),
    );
  }
}
