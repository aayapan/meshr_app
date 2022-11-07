
import 'package:flutter/material.dart';
import 'package:meshr_app/screens/step-two-txt.dart';
import 'package:meshr_app/screens/step-two-page-one.dart';

class StepTwoPageFour extends StatelessWidget {
  String textDescription;
  StepTwoPageFour({
    Key? key, required this.textDescription,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StepTwoPageOne(descriptionInput: textDescription),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GenerateStepTwoText(userPrompt: "",)));
              }),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(11)),
                  border: Border.all(color: Colors.white, width: 4),
                  color: const Color(0xFF1B8D01),
                ),
                width: 140,
                height: 68,
                child: const Center(
                  child: Text(
                    "Proceed",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(11)),
                  border: Border.all(color: Colors.white, width: 4),
                  color: const Color(0xFF8D0000),
                ),
                width: 140,
                height: 68,
                child: const Center(
                  child: Text(
                    "Retry",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}