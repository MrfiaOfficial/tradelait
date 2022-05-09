import 'dart:io';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/screens/auth/auth_home_screen.dart';
import 'package:tradelait/wrapper/provider_wrapper.dart';
import 'package:flutter/services.dart';
import 'package:tradelait/users/models/user.dart';
import 'package:tradelait/services/auth/auth.dart';
import 'package:tradelait/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: Palette.firebaseNavy, //Colors.white,
          systemNavigationBarIconBrightness: Brightness.light));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    //final brokerservice = Provider.of<brokerservice>(context);
    return StreamBuilder<User?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            //return user == null ? LoginScreen() : PrivateWrapper2();
            return user == null ? AuthHomeScreen() : PrivateWrapper2();
          } else {
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
        });

    // return either the Home or Authenticate widget
    /* if (user == null) {
      return LoginScreen();
    } else {
      return RegistrationScreen();
    } */
  }
}
