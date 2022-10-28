// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:meshr_app/screens/image-help.dart';
import 'package:meshr_app/widgets/generate-footer.dart';
import 'package:meshr_app/widgets/generate-header.dart';
import 'package:meshr_app/widgets/output-item.dart';

class GenerateStepTwoText extends StatefulWidget {
  GenerateStepTwoText({Key? key,}) : super(key: key); 

  @override
  State<GenerateStepTwoText> createState() => _GenerateStepTwoTextState();
}

class _GenerateStepTwoTextState extends State<GenerateStepTwoText> {

  int listLength = 3;
  List<String> myList = [];
  // late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getData();
  }

  // Future getData() async {
  //   prefs = await SharedPreferences.getInstance();
  //   myList = prefs.getStringList('thumb-list')!;
  //   print(myList);
  // }

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
                header: "Step 2:", subheader: "Choose your desired output"),
            Expanded(
                child: Container(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(listLength, (index) {
                  return OutputItem();
                }),
              ),
            )),
          ],
        ),
      ),
      bottomNavigationBar: GenerateBottomNav(helpFunction: (){
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return HelpScreen(header: "Choose!", footer: "After reviewing the input, and you agreed with how the system understood your description, then it's time to choose. \n\n Choose from a set of generated 2D images that are based from your description. Tapping a design will generate a 3D version of that picture.",);
        })));
      },),
    );
  }
}


