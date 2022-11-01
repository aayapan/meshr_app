// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:meshr_app/screens/image-help.dart';
import 'package:meshr_app/screens/view-gallery-img.dart';
import 'package:meshr_app/screens/view-output-img.dart';
import 'package:meshr_app/widgets/generate-footer.dart';
import 'package:meshr_app/widgets/generate-header.dart';
import 'package:meshr_app/widgets/output-item.dart';

class GenerateStepTwoText extends StatefulWidget {
  GenerateStepTwoText({
    Key? key,
  }) : super(key: key);

  @override
  State<GenerateStepTwoText> createState() => _GenerateStepTwoTextState();
}

class _GenerateStepTwoTextState extends State<GenerateStepTwoText> {
  int listLength = 4;
  late List<String> myList;
  // late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getData();
  }

  Future<List<String>> textToImage() async {
    List<String> response = [];
    await Future.delayed(Duration(seconds: 10)).then((value) {
      print('PASOK KA SA FUTURE');
      response = ['test', 'test2'];
    });
    return response;
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
          children: [
            GenerateHeaderText(
                header: "Step 2:", subheader: "Choose your desired output"),
            Expanded(
                child: Container(
              child: FutureBuilder<List<String>>(
                future: textToImage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(snapshot.data!.length, (index) {
                          return OutputItem(onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: ((context) {
                              return ViewOutputImage();
                            })));
                          });
                        }),
                      );
                    }
                  }
                },
              ),
              // child: GridView.count(
              //   crossAxisCount: 2,
              //   children: List.generate(listLength, (index) {
              //     return OutputItem(onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: ((context) {
              //         return ViewOutputImage();
              //       })));
              //     });
              //   }),
              // ),
            )),
          ],
        ),
      ),
      bottomNavigationBar: GenerateBottomNav(
        helpFunction: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return HelpScreen(
              header: "Choose!",
              footer:
                  "After reviewing the input, and you agreed with how the system understood your description, then it's time to choose. \n\n Choose from a set of generated 2D images that are based from your description. Tapping a design will generate a 3D version of that picture.",
            );
          })));
        },
      ),
    );
  }
}
