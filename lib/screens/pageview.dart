import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class KALBO extends StatelessWidget {
  KALBO({super.key});
  @override
  List list = ['TEST', 'TEST2', 'TEST3'];
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Container(
          child: Center(child: Text(list[index])),
        );
      },
      itemCount: list.length,
    );
  }
}