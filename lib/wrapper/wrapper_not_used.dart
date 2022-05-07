import '../users/models/user.dart';
//import 'auth.dart';
import '../screens/auth/registration_screen.dart';
import '../screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    // ignore: unnecessary_null_comparison
    if (user == null) {
      return LoginScreen();
    } else {
      return RegistrationScreen();
    }
  }
}
