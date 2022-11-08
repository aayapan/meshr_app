// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:meshr_app/linker/request_id_generator.dart';
import 'package:meshr_app/linker/send_to_server.dart';
import 'package:meshr_app/screens/image-help.dart';
import 'package:meshr_app/screens/view-gallery-img.dart';
import 'package:meshr_app/screens/view-output-img.dart';
import 'package:meshr_app/widgets/generate-footer.dart';
import 'package:meshr_app/widgets/generate-header.dart';
import 'package:meshr_app/widgets/output-item.dart';
import 'package:meshr_app/widgets/shimmer-loading.dart';

class GenerateStepTwoText extends StatefulWidget {
  String userPrompt;
  GenerateStepTwoText({Key? key, required this.userPrompt}) : super(key: key);

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
    final user = FirebaseAuth.instance.currentUser!.displayName;
    RequestHandler rh = RequestHandler();
    String rqid = RequestID.create(user!);
    response = await rh.tx2im_request(rqid, widget.userPrompt);
    // await Future.delayed(Duration(seconds: 10));
    // response = [
    //   "https://meshr-cloud-storage.s3.ap-south-1.amazonaws.com/T2I_Output/e051184a408f43850790c697cdd3bd870de2b98f_1_2022-11-06.jpg",
    //   "https://meshr-cloud-storage.s3.ap-south-1.amazonaws.com/T2I_Output/e051184a408f43850790c697cdd3bd870de2b98f_1_2022-11-06.jpg"
    // ];
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
            Container(
              margin: EdgeInsets.only(top: 30, left: 15, right: 15),
              width: double.infinity,
              child: Center(
                  child: Text(
                'Prompt: ${widget.userPrompt}',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                    color: Color(0xFF2D2B2B)),
              )),
            ),
            Expanded(
                child: Container(
              child: FutureBuilder<List<String>>(
                future: textToImage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(4, (index) {
                          return getShimmer();
                        }),
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
                          return OutputItem(
                              imageUrl: snapshot.data![index],
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: ((context) {
                                  return ViewOutputImage(
                                      imageUrl: snapshot.data![index]);
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
