import 'dart:ui';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/constants/Theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../users/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Home',
        ),
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      //drawer: ArgonDrawer(currentPage: "Home"),
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Stack(
          children: <Widget>[
            /* Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/logo.png"),
                    fit: BoxFit.fitWidth),
              ),
            ), */

            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 74.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: <Widget>[
                            SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: .0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 85.0, bottom: 20.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 40.0),
                                            Align(
                                              child: Text(
                                                  "${loggedInUser.firstName} ${loggedInUser.lastName}",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 28.0)),
                                            ),
                                            SizedBox(height: 10.0),
                                            Align(
                                              child: Text(
                                                "${loggedInUser.schoolName}",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        50, 50, 93, 1),
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
                                            ),
                                            Divider(
                                              height: 40.0,
                                              thickness: 1.5,
                                              indent: 32.0,
                                              endIndent: 32.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 32.0, right: 32.0),
                                              child: Align(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "${loggedInUser.email}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              82, 95, 127, 1),
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.w200),
                                                    ),
                                                    Text(
                                                      '+2349032348435',
                                                      //"${loggedInUser.phoneNumber} ?? '",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              82, 95, 127, 1),
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.w200),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 25.0),
                                            /* Align(
                                            child: Text(
                                              "PAYMENT",
                                              style: TextStyle(
                                                  color: ArgonColors.primary,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.0),
                                            ),
                                          ), */
                                            SizedBox(height: 25.0),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 25.0, left: 25.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Update Account",
                                                    style: TextStyle(
                                                        color: Palette
                                                            .firebaseOrange,
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "Logout",
                                                    style: TextStyle(
                                                        color: Palette
                                                            .firebaseOrange,
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            FractionalTranslation(
                              translation: Offset(0.0, -0.5),
                              child: Align(
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/logo.png"),
                                  radius: 65.0,
                                  backgroundColor: Palette.firebaseNavy,
                                  // maxRadius: 200.0,
                                ),
                                alignment: FractionalOffset(0.5, 0.0),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}