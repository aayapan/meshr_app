import 'package:flutter/material.dart';

class StepTwoPageThree extends StatelessWidget {
  const StepTwoPageThree({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "75",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  fontSize: 110.0,
                  color: Color(0xFF1B8D01),
                ),
              ),
              Text(
                "%\nCorrect",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  fontSize: 40.0,
                  color: Color(0xFF1B8D01),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "25",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  fontSize: 74.0,
                  color: Color(0xFF8D0000),
                ),
              ),
              Text(
                "%\nWrong",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  fontSize: 28.0,
                  color: Color(0xFF8D0000),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
