// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, avoid_print, sort_child_properties_last

import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshr_app/data/local-storage.dart';
import 'package:meshr_app/screens/main_menu.dart';
import 'package:meshr_app/screens/step-two-3d.dart';
import 'package:meshr_app/screens/step-two-img.dart';
import 'package:meshr_app/screens/step-two.dart';
import 'package:meshr_app/widgets/generate-footer.dart';
import 'package:meshr_app/widgets/generate-header.dart';
import 'package:meshr_app/widgets/proceed-button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class GenerateStepOne3D extends StatefulWidget {
  GenerateStepOne3D({
    Key? key,
  }) : super(key: key);

  @override
  State<GenerateStepOne3D> createState() => _GenerateStepOne3DState();
}

class _GenerateStepOne3DState extends State<GenerateStepOne3D> {
  File? _image;

  final _myBox = Hive.box('FilesCollection');
  FilesLocalStorage fls = FilesLocalStorage();


  Future captureImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final img = await saveImagePermanently(image.path);
      print("IMAGE PATH: ${img.path}");

      setState(() {
        _image = img;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<File> saveImagePermanently(
      String imagePath) async {
    final directory = await getExternalStorageDirectory();

    final name = basename(imagePath);
    final image =
        File('${directory?.path}/$name.jpeg');
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFEFB83C),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ImageIcon(AssetImage("assets/images/back-icon.png")),
            iconSize: 40.0,
            color: Colors.white,
          ),
        ),
        body: Container(
          width: double.infinity,
          color: Color(0xFFEFB83C),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 140,
              ),
              GenerateHeaderText(
                  header: "Step 1:",
                  subheader:
                      "Take a picture of the front of object that you want to convert as a 3D Object."),
              SizedBox(
                height: 50,
              
              ),
              MaterialButton(
                onPressed: () {
                  captureImage().then((value) {
                    print("CHANGE NAVIGATION");
                    if (_image == null) {
                      setState(() {});
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              GenerateStepTwo3D(displayImage: _image!)));
                    }
                  });
                },
                color: Colors.white,
                textColor: Colors.black,
                elevation: 3,
                child: Icon(
                  Icons.camera_alt,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              Container(
                margin: EdgeInsets.only(top: 6),
                child: Text(
                  "Capture",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: GenerateBottomNav(helpFunction: () {}));
  }
}
