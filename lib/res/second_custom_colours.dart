import 'package:flutter/material.dart';

class Palette2 {
  static const MaterialColor custom = const MaterialColor(
    0xffaf1b56, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff9e184d), //10%
      100: const Color(0xff8c1645), //20%
      200: const Color(0xff7a133c), //30%
      300: const Color(0xff691034), //40%
      400: const Color(0xff580e2b), //50%
      500: const Color(0xff460b22), //60%
      600: const Color(0xff34081a), //70%
      700: const Color(0xff230511), //80%
      800: const Color(0xff110309), //90%
      900: const Color(0xff000000), //100%
    },
  );
}
