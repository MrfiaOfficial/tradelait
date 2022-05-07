import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  CustomButton(this.text, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          //color: Palette.firebaseGrey,
          color: textColor,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
