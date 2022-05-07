import 'package:tradelait/res/custom_colors.dart';
import 'package:flutter/material.dart';

class HomeBox extends StatelessWidget {
  final String title;
  final String description;
  final Icon icon;

  const HomeBox(
      {required this.title,
      required this.icon,
      required this.description,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* void _showModalPopUp() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: ModalPopUp(
              modalTitle: title,
              modalDescription: description,
            ),
          );
        },
      );
    } */

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Palette.firebaseNavy,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: SizedBox(
                height: 80,
                child: icon,
                /* child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
              ), */
              ),
            ),
            SizedBox(height: 5.0),
            Flexible(
              child: Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Palette.firebaseGrey,
                  //color: Palette.firebaseOrange,
                ),
                //color: Palette.firebaseYellow,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      /* color: Palette.firebaseNavy, */ fontSize: 12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
