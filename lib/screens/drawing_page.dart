// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:meshr_app/screens/drawn_line.dart';
import 'package:meshr_app/screens/sketcher.dart';
import 'package:meshr_app/screens/step-two-img.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  // List of Files to pass to the server
  List<File> filesToPass = [];

  final GlobalKey _globalKey = GlobalKey();
  List<DrawnLine> lines = <DrawnLine>[];
  late DrawnLine? line;
  Color selectedColor = Colors.black;
  double selectedWidth = 5.0;

  StreamController<List<DrawnLine>> linesStreamController =
      StreamController<List<DrawnLine>>.broadcast();
  StreamController<DrawnLine> currentLineStreamController =
      StreamController<DrawnLine>.broadcast();

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
      minHeight: 512,
      minWidth: 512,
    );

    print(file.lengthSync());
    print(result!.lengthSync());

    return result;
  }

  Future<void> save() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      // final name = basename(imagePath);
      File file =
          File('${directory.path}/${DateTime.now().toIso8601String()}.jpg');
      file = await file.writeAsBytes(pngBytes, flush: true);

      filesToPass.add(file);

      // var saved = await ImageGallerySaver.saveImage(
      //   pngBytes,
      //   quality: 100,
      //   name: DateTime.now().toIso8601String() + ".png",
      //   isReturnImagePathOfIOS: true,
      // );

      // print(saved);
    } catch (e) {
      print(e);
    }
  }

  Future<void> clear() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Canvas has been cleared!",
        style: TextStyle(
            fontFamily: 'Roboto', fontWeight: FontWeight.w700, fontSize: 15),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Color(0xFFEFB83C),
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
      elevation: 0,
    ));
    setState(() {
      lines = [];
      line = DrawnLine([], null, null);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    line = DrawnLine([], null, null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2B2B),
      body: Stack(
        children: [
          buildAllPaths(context),
          buildCurrentPath(context),
          buildColorToolbar(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'saveAndProceed',
        backgroundColor: Color(0xFFEFB83C),
        onPressed: () {
          save().then((value) async {
            final result = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return GenerateStepTwoImage(files: filesToPass);
            }));
            print("RESULT: $result");
            if (result) {
              setState(() {
                filesToPass = [];
              });
            }
          });
        },
        child: Icon(
          Icons.arrow_right_alt_rounded,
          size: 50.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildCurrentPath(BuildContext context) {
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: RepaintBoundary(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(4.0),
          color: Colors.transparent,
          alignment: Alignment.topLeft,
          child: StreamBuilder<DrawnLine>(
            stream: currentLineStreamController.stream,
            builder: (context, snapshot) {
              return CustomPaint(
                painter: Sketcher(
                  lines: [line!],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildAllPaths(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        padding: EdgeInsets.all(4.0),
        alignment: Alignment.topLeft,
        child: StreamBuilder<List<DrawnLine>>(
          stream: linesStreamController.stream,
          builder: (context, snapshot) {
            return CustomPaint(
              painter: Sketcher(
                lines: lines,
              ),
            );
          },
        ),
      ),
    );
  }

  void onPanStart(DragStartDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset point = box.globalToLocal(details.globalPosition);
    line = DrawnLine([point], selectedColor, selectedWidth);
  }

  void onPanUpdate(DragUpdateDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset point = box.globalToLocal(details.globalPosition);

    List<Offset> path = List.from(line!.path)..add(point);
    line = DrawnLine(path, selectedColor, selectedWidth);
    currentLineStreamController.add(line!);
  }

  void onPanEnd(DragEndDetails details) {
    lines = List.from(lines)..add(line!);

    linesStreamController.add(lines);
  }


  Widget buildStrokeButton(double strokeWidth) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedWidth = strokeWidth;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: strokeWidth * 2,
          height: strokeWidth * 2,
          decoration: BoxDecoration(
              color: selectedColor, borderRadius: BorderRadius.circular(50.0)),
        ),
      ),
    );
  }

  Widget buildColorToolbar() {
    return Positioned(
      top: 40.0,
      right: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildClearButton(),
          Divider(
            height: 10.0,
          ),
          buildBackButton(),
          Divider(
            height: 20.0,
          ),
          buildColorButton(Colors.red),
          buildColorButton(Colors.blueAccent),
          buildColorButton(Colors.deepOrange),
          buildColorButton(Colors.green),
          buildColorButton(Colors.lightBlue),
          buildColorButton(Colors.black),
          buildColorButton(Colors.white),
        ],
      ),
    );
  }

  Widget buildColorButton(Color color) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FloatingActionButton(
        heroTag: null,
        mini: true,
        backgroundColor: color,
        child: Container(),
        onPressed: () {
          setState(() {
            selectedColor = color;
          });
        },
      ),
    );
  }

  Widget buildBackButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: CircleAvatar(
        backgroundColor: Color(0xFFEFB83C),
        child: Icon(
          Icons.arrow_back_rounded,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildClearButton() {
    return GestureDetector(
      onTap: clear,
      child: CircleAvatar(
        backgroundColor: Color(0xFFEFB83C),
        child: Icon(
          Icons.delete,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
