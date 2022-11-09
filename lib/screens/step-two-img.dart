// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:meshr_app/linker/request_id_generator.dart';
import 'package:meshr_app/linker/send_to_server.dart';
import 'package:meshr_app/linker/set_filename.dart';
import 'package:meshr_app/screens/bottom_navigation.dart';
import 'package:meshr_app/screens/image-help.dart';
import 'package:meshr_app/screens/step-two-txt.dart';
import 'package:meshr_app/screens/step-two.dart';
import 'package:meshr_app/screens/view-output-img.dart';
import 'package:meshr_app/widgets/generate-footer.dart';
import 'package:meshr_app/widgets/generate-header.dart';
import 'package:meshr_app/widgets/proceed-button.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class GenerateStepTwoImage extends StatefulWidget {
  List<File> files;
  GenerateStepTwoImage({Key? key, required this.files}) : super(key: key);

  @override
  State<GenerateStepTwoImage> createState() => _GenerateStepTwoImageState();
}

class _GenerateStepTwoImageState extends State<GenerateStepTwoImage> {
  String _enteredText = '';
  late int charCounter;
  bool _clickable = false;
  String text = "Proceed";

  FileHandler fh = FileHandler();
  RequestHandler rh = RequestHandler();
  late List<String> _filename;

  final user = FirebaseAuth.instance.currentUser!.displayName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.files);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFEFB83C),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
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
          children: [
            GenerateHeaderText(
                header: "Step 2:",
                subheader: "Enter the keywords that describe your design"),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _enteredText = value;
                        charCounter = 0;
                        for (int i = 0; i < _enteredText.length; i++) {
                          if (_enteredText[i] != " ") {
                            charCounter++;
                          }
                        }
                        print(charCounter);
                        _clickable = charCounter >= 3 ? true : false;
                      });
                    },
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(22.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)),
                      hintText: 'Type Here',
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFBABABA),
                        fontSize: 17,
                      ),
                    ),
                  ),
                  ProceedButton(
                    text: text,
                    clickable: _clickable,
                    onPressed: () async {
                      setState(() {
                        _clickable = false;
                        text = "Generating";
                      });

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Image Generating! Please wait...",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Color(0xFFEFB83C),
                        duration: Duration(seconds: 8),
                        behavior: SnackBarBehavior.floating,
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                        elevation: 3,
                      ));

                      FocusManager.instance.primaryFocus?.unfocus();
                      List<String> response = [];
                      var name = utf8.encode(
                          (FirebaseAuth.instance.currentUser!.displayName)!);
                      String user = sha1.convert(name).toString();
                      String rqid = RequestID.create(user);
                      _filename = FileNameConvert.convert(widget.files, rqid);
                      await fh.upload(rqid, widget.files);
                      response = await rh.im2im_request(
                          rqid, _enteredText, fh, _filename, user);

                      final result =
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewOutputImage(
                                    imageUrl: response[0],
                                  )));
                      print("RESULT: $result");
                      if (result) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) {
                          return GenerateStepTwoImage(files: widget.files);
                        })));
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GenerateBottomNav(
        helpFunction: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return HelpScreen(
              header: "Define!",
              footer:
                  "Find the right words that would define your target design, the more specific your definition is the more specific the output will be.",
            );
          })));
        },
      ),
    );
  }
}
