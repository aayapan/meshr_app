// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class Image2ImageChoice extends StatelessWidget {
  String icon;
  VoidCallback onPressed;
  Image2ImageChoice({Key? key, required this.icon, required this.onPressed})
      : super(key: key);
      
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(const Radius.circular(12)),
          color: Colors.white,
        ),
        child: Center(child: Image.asset(icon)),
      ),
    );
  }
}
