// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class GenerateHeaderText extends StatelessWidget {
  String header;
  String subheader;
  GenerateHeaderText({Key? key, required this.header, required this.subheader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              header,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w900,
                fontSize: 75,
                color: Color(0xFF2D2B2B),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              subheader,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Color(0xFF2D2B2B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
