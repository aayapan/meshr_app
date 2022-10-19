// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import 'package:meshr_app/screens/step-two-page-four.dart';
import 'package:meshr_app/screens/step-two-page-one.dart';
import 'package:meshr_app/screens/step-two-page-three.dart';
import 'package:meshr_app/screens/step-two-page-two.dart';
import 'package:meshr_app/widgets/generate-footer.dart';
import 'package:meshr_app/widgets/generate-header.dart';

class GenerateStepTwo extends StatefulWidget {
  String inputString;
  int currentPageIndex;
  GenerateStepTwo(
      {Key? key, this.currentPageIndex = 0, required this.inputString,})
      : super(key: key);

  @override
  State<GenerateStepTwo> createState() => _GenerateStepTwoState();
}

class _GenerateStepTwoState extends State<GenerateStepTwo> {
  final PageController _pageController = PageController(initialPage: 0);
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: Color(0xFFEFB83C),
          child: Column(
            children: [
              //  STEPS and Description
              GenerateHeaderText(
                  header: "Step 2:",
                  subheader:
                      "This shows the breakdown of your input, it shows what the system understood"),
              Container(
                height: 230,
                width: double.infinity,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      widget.currentPageIndex = index;
                    });
                  },
                  children: [
                    StepTwoPageOne(descriptionInput: widget.inputString),
                    StepTwoPageTwo(),
                    StepTwoPageThree(),
                    StepTwoPageFour(textDescription: widget.inputString,),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: List.generate(4, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.5),
                        child: GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(index,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          child: Container(
                            width: index == widget.currentPageIndex ? 18 : 9,
                            height: index == widget.currentPageIndex ? 18 : 9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF3A38388A),
                            ),
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GenerateBottomNav(),
    );
  }
}



