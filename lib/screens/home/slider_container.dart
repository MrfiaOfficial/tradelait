import 'package:tradelait/res/custom_colors.dart';
import 'package:flutter/material.dart';

class SliderCont extends StatelessWidget {
  final assetImage;
  final sliderText;
  final sliderDescription;
  final Widget? screen;
  //final String? screenRoute;

  const SliderCont({
    Key? key,
    required this.assetImage,
    required this.sliderText,
    required this.sliderDescription,
    required this.screen,
    //this.screenRoute,
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
        /* onTap: () {
          Navigator.pushNamed(context, screenRoute!);
        }, */
        child: Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            border: Border.all(width: 4, color: Palette.firebaseWhite),
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: assetImage,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child: Container(
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
                      SizedBox(height: 35),
                      Center(
                        child: Text(
                          sliderDescription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Palette.firebaseYellow,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
