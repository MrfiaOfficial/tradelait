import 'dart:ui';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/users/screens/user_edit_screen.dart';
import 'package:tradelait/screens/home/home_box.dart';
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
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.settings,
              color: Palette.firebaseOrange,
            ),
            label: Text(
              'Settings',
              style: TextStyle(color: Palette.firebaseOrange),
            ),
            onPressed: () => () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserEditScreen(
                    currentFirstName: loggedInUser.firstName ?? '',
                    currentLastName: loggedInUser.lastName ?? '',
                    currentUserName: loggedInUser.userName ?? '',
                    currentGender: loggedInUser.gender ?? '',
                    currentSchoolName: loggedInUser.schoolName ?? '',
                    currentPictureUrl: loggedInUser.pictureUrl ?? '',
                    currentPhone: loggedInUser.phone ?? '',
                    currentEmail: loggedInUser.email ?? '',
                    currentHouseNumber: loggedInUser.houseNumber ?? '',
                    currentStreet: loggedInUser.street ?? '',
                    currentCity: loggedInUser.city ?? '',
                    currentState: loggedInUser.state ?? '',
                    currentCountry: loggedInUser.country ?? '',
                    uid: currentUser!.uid,
                  ),
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
        ],
      ),
      backgroundColor: Palette.firebaseYellow,
      //drawer: ArgonDrawer(currentPage: "Home"),
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Palette.firebaseNavy,
                  /* border: Border.all(
                    width: 5.0,
                    color: Palette.firebaseAmber,
                  ), */
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Center(
                  child: Text(
                    loggedInUser.schoolName.toString(),
                    style: TextStyle(
                      fontSize: 30,
                      color: Palette.firebaseYellow,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 0,
                /* shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ), */
                child: Container(
                  color: Palette.firebaseYellow,
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HomeBox(
                              icon: Icon(
                                Icons.people,
                                color: Palette.firebaseOrange,
                                size: 40,
                              ),
                              title: 'Comfortable Student Data Management',
                              description:
                                  'Comfortable Student Data Management',
                            ),
                            SizedBox(width: 20),
                            HomeBox(
                              icon: Icon(
                                Icons.payments_rounded,
                                color: Palette.firebaseOrange,
                                size: 40,
                              ),
                              title: 'Easy Payment Processing and Recording',
                              description:
                                  'Easy Payment Processing and Recording',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HomeBox(
                              icon: Icon(
                                Icons.receipt_long_rounded,
                                color: Palette.firebaseOrange,
                                size: 40,
                              ),
                              title: 'Seamless Receipt Generation & Printing',
                              description:
                                  'Seamless Receipt Generation & Printing',
                            ),
                            SizedBox(width: 20),
                            HomeBox(
                              icon: Icon(
                                Icons.payment_sharp,
                                color: Palette.firebaseOrange,
                                size: 40,
                              ),
                              title: 'Easy Income & Expenditure Reporting',
                              description:
                                  'Seamless Receipt Generation & Printing',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HomeBox(
                              icon: Icon(
                                Icons.workspaces,
                                color: Palette.firebaseOrange,
                                size: 40,
                              ),
                              title: 'Effective Staff Records Management',
                              description:
                                  'Seamless Receipt Generation & Printing',
                            ),
                            SizedBox(width: 20),
                            HomeBox(
                              icon: Icon(
                                Icons.assessment,
                                color: Palette.firebaseOrange,
                                size: 40,
                              ),
                              title: 'Accurate School Assets Management',
                              description:
                                  'Seamless Receipt Generation & Printing',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
