// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class StepTwoPageTwo extends StatelessWidget {
  const StepTwoPageTwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "4",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              fontSize: 110.0,
              color: Color(0xFF2D2B2B),
            ),
          ),
          Text(
            "keywords\nfound",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              fontSize: 40.0,
              color: Color(0xFF2D2B2B),
            ),
          ),
        ],
      ),
    );
  }
}