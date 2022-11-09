// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class ProceedButton extends StatefulWidget {
  bool clickable;
  VoidCallback onPressed;
  String text;
  ProceedButton({
    Key? key,
    required this.clickable,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  State<ProceedButton> createState() => _ProceedButtonState();
}

class _ProceedButtonState extends State<ProceedButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(top: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
                color: widget.clickable ? Color(0xFF2D2B2B) : Colors.white,
                width: 4),
            color: widget.clickable ? Color(0xFF2D2B2B) : Colors.transparent,
          ),
          height: 83,
          width: 173,
          child: TextButton(
            style: ButtonStyle(
              overlayColor: widget.clickable
                  ? MaterialStateProperty.all(
                      Color.fromARGB(104, 255, 255, 255))
                  : MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: widget.clickable ? widget.onPressed : null,
            child: Text(
              widget.text,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
