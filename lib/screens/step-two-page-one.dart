import 'package:flutter/material.dart';

class StepTwoPageOne extends StatelessWidget {
  String descriptionInput;
  StepTwoPageOne({
    Key? key, required this.descriptionInput
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(11)),
          color: Colors.white,
        ),                  
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            descriptionInput,
            style: TextStyle(
              fontFamily:'Roboto',
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}