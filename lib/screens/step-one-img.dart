// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import "package:flutter/material.dart";
import 'package:meshr_app/screens/step-three-img.dart';
import 'package:meshr_app/screens/step-two.dart';
import 'package:meshr_app/widgets/generate-footer.dart';
import 'package:meshr_app/widgets/generate-header.dart';
import 'package:meshr_app/widgets/proceed-button.dart';

class GenerateStepOneImage extends StatefulWidget {
  GenerateStepOneImage({Key? key,}) : super(key: key);

  @override
  State<GenerateStepOneImage> createState() => _GenerateStepOneImageState();
}

class _GenerateStepOneImageState extends State<GenerateStepOneImage> {
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
                          if(_enteredText[i] != " "){
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
                    clickable: _clickable,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GenerateStepTwoImage()));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GenerateBottomNav(),
    );
  }
}
