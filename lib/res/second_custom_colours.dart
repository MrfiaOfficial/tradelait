import 'package:flutter/material.dart';

class Palette2 {
  static const MaterialColor custom = const MaterialColor(
    0xff451EE1, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff3e1bcb), //10%
      100: const Color(0xff3718b4), //20%
      200: const Color(0xff30159e), //30%
      300: const Color(0xff291287), //40%
      400: const Color(0xff230f71), //50%
      500: const Color(0xff1c0c5a), //60%
      600: const Color(0xff150943), //70%
      700: const Color(0xff0e062d), //80%
      800: const Color(0xff070316), //90%
      900: const Color(0xff000000), //100%
    },
  );
}
