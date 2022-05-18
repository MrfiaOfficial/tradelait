import 'package:tradelait/res/custom_colors.dart';
import 'package:flutter/material.dart';

class SliderContFull extends StatelessWidget {
  final assetImage;
  final sliderText;
  final sliderDescription;
  final Widget? screen;

  const SliderContFull({
    Key? key,
    required this.assetImage,
    required this.sliderText,
    required this.sliderDescription,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => screen!,
            ),
          );
        },
        child: Container(
          //margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            border: Border.all(width: 4, color: Palette.firebaseGrey),
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: assetImage,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        sliderText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Palette.firebaseWhite,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        sliderDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Palette.firebaseYellow,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
