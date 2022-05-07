import 'dart:ui';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/screens/home/home_slider_full.dart';
import 'package:tradelait/users/screens/user_profile_screen.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tradelait/users/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  var currentUser = FirebaseAuth.instance.currentUser;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
    /* void _showModalPopUp() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: ModalPopUp(
              modalTitle: 'Title',
              modalDescription: 'Description',
            ),
          );
        },
      );
    } */

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: '',
        ),
        /* actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.settings,
              color: Palette.firebaseOrange,
            ),
            label: Text(
              'Account',
              style: TextStyle(color: Palette.firebaseOrange),
            ),
            onPressed: () => () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserProfileScreen(),
                ),
              );
              //Navigator.of(context).pop();
            },
          ),
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: Palette.firebaseOrange,
            ),
            label: Text(
              'Logout',
              style: TextStyle(color: Palette.firebaseOrange),
            ),
            onPressed: () async {
              await _firebaseAuth.signOut();
            },
          ),
        ], */
      ),
      backgroundColor: Palette.firebaseYellow,
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Palette.firebaseNavy,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Center(
                  child: Text(
                    loggedInUser.schoolName ?? '',
                    style: TextStyle(
                      fontSize: 30,
                      color: Palette.firebaseYellow,
                    ),
                  ),
                ),
              ),
            ),
            /* Expanded(
              flex: 1,
              child: Container(
                /* decoration: BoxDecoration(
                  color: Palette.firebaseNavy,
                  borderRadius: BorderRadius.circular(40.0),
                ), */
                margin: EdgeInsets.all(0),
                color: Palette.firebaseOrange,
                child: Center(
                  child: Text(
                    'Manage your school with ease',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      //color: Palette.,
                    ),
                  ),
                ),
              ),
            ), */
            Expanded(
              flex: 7,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Container(
                  color: Palette.firebaseYellow,
                  //padding: EdgeInsets.only(bottom: 30),
                  child: HomeSliderFull(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
