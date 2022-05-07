import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final onPressed;
  final String text;
  final Color bgColor;
  final Color textColor;

  CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.bgColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            bgColor,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
