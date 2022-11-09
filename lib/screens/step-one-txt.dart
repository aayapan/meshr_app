// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:meshr_app/linker/send_to_server.dart';
import 'package:meshr_app/screens/image-help.dart';
import 'package:meshr_app/screens/step-two-txt.dart';
import 'package:meshr_app/screens/step-two.dart';
import 'package:meshr_app/widgets/generate-footer.dart';
import 'package:meshr_app/widgets/generate-header.dart';
import 'package:meshr_app/widgets/proceed-button.dart';

import 'package:meshr_app/linker/request_id_generator.dart';

class GenerateStepOneText extends StatefulWidget {
  GenerateStepOneText({
    Key? key,
  }) : super(key: key);

  @override
  State<GenerateStepOneText> createState() => _GenerateStepOneTextState();
}

class _GenerateStepOneTextState extends State<GenerateStepOneText> {
  String _enteredText = '';
  late int charCounter;
  bool _clickable = false;

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
          children: [
            GenerateHeaderText(
                header: "Step 1:",
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
                  Text(
                    "Example: Red Heart-Shaped Vase",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w100,
                      fontSize: 17,
                    ),
                  ),
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
                    text: "Proceed",
                    clickable: _clickable,
                    onPressed: () {
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
                        duration: Duration(seconds: 30),
                        behavior: SnackBarBehavior.floating,
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                        elevation: 3,
                      ));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              GenerateStepTwoText(userPrompt: _enteredText)));
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
