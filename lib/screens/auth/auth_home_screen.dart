import 'dart:async';
import 'dart:ui';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/screens/auth/login_screen.dart';
import 'package:tradelait/screens/auth/registration_screen.dart';
import 'package:tradelait/wrapper/wrapper.dart';
import 'package:flutter/material.dart';

class AuthHomeScreen extends StatefulWidget {
  @override
  _AuthHomeState createState() => _AuthHomeState();
}

class _AuthHomeState extends State<AuthHomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wrapper()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Login Button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Palette.firebaseNavy,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        ),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    //Signup Button
    //Login Button
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Palette.firebaseNavy,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RegistrationScreen(),
          ),
        ),
        child: Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Palette.firebaseWhite,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/tradelait_logo_round.png",
                    height: 200.0,
                    width: 200.0,
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Premium Forex, Crypto & Stocks Trading Signals & Tools!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text("Already registered? "),
                  SizedBox(height: 5),
                  loginButton,
                  SizedBox(height: 20),
                  Text("Don't have an account?"),
                  SizedBox(height: 5),
                  signupButton,
                  SizedBox(height: 5),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
