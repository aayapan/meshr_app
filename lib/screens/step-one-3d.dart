// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:camera/camera.dart';
import "package:flutter/material.dart";
import 'package:meshr_app/screens/main_menu.dart';
import 'package:meshr_app/screens/step-three-img.dart';
import 'package:meshr_app/screens/step-two.dart';
import 'package:meshr_app/widgets/generate-footer.dart';
import 'package:meshr_app/widgets/generate-header.dart';
import 'package:meshr_app/widgets/proceed-button.dart';

class GenerateStepOne3D extends StatefulWidget {
  List<CameraDescription> cameras;
  GenerateStepOne3D({Key? key, required this.cameras}) : super(key: key);

  @override
  State<GenerateStepOne3D> createState() => _GenerateStepOne3DState();
}

class _GenerateStepOne3DState extends State<GenerateStepOne3D> {
  // late List<CameraDescription> cameras;
  late CameraController cameraController;

  @override
  void initState() {
    startCamera();

    super.initState();
  }

  void startCamera() async {
    // cameras = await availableCameras();

    print("Camera Init");
    cameraController = CameraController(
        widget.cameras[0], ResolutionPreset.high,
        enableAudio: false);

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e){
      print(e);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
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
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => MainMenu(
                          )),
                  (Route route) => false);
            },
            child: Container(
              margin: EdgeInsets.only(right: 8),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3.8,
                  )),
              child: ImageIcon(
                AssetImage("assets/images/home-icon.png"),
                size: 30.9,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: 20),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ImageIcon(
                AssetImage("assets/images/help-icon.png"),
                size: 40.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Color(0xFFEFB83C),
        child: Column(
          children: [
            GenerateHeaderText(
                header: "Step 1:",
                subheader:
                    "Take a picture of the front of object that you want to convert as a 3D Object."),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.transparent,
                child: cameraController.value.isInitialized ? CameraPreview(cameraController) : SizedBox(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFFEFB83C),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 50,
              width: 50,
              color: Colors.transparent,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 5,
                  )),
              child: RawMaterialButton(
                onPressed: () {},
                fillColor: Color(0xFFEFB83C),
                padding: EdgeInsets.all(5.0),
                shape: CircleBorder(),
                child: ImageIcon(
                  AssetImage("assets/images/shutter-icon.png"),
                  size: 50.0,
                  color: Colors.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ImageIcon(
                  AssetImage("assets/images/grid-icon.png"),
                  size: 50.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
