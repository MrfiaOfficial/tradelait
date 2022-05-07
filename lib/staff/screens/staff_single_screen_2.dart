import 'dart:ui';
import 'package:tradelait/salaries/screens/salary_add_screen.dart';
import 'package:tradelait/staff/models/staff_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/staff/screens/staff_edit_screen.dart';
import 'package:tradelait/staff/services/staff_service.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:tradelait/users/models/user_model.dart';

// ignore: must_be_immutable
class StaffSingleScreen2 extends StatefulWidget {
  final String staffUid;
  String firstName;
  String lastName;

  StaffSingleScreen2({
    Key? key,
    required this.staffUid,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  @override
  _StaffSingleScreen2State createState() => _StaffSingleScreen2State();
}

class _StaffSingleScreen2State extends State<StaffSingleScreen2> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: widget.firstName + ' ' + widget.lastName,
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: StaffService(uid: currentUser!.uid)
            .readSingleStaff(widget.staffUid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            Map<String, dynamic> staffInfo =
                snapshot.data!.data() as Map<String, dynamic>;

            return Container(
              margin: EdgeInsets.only(top: 40.0),
              child: Stack(
                children: <Widget>[
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
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 5,
                                      //color: Palette.firebaseYellow,
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
                                                      "${staffInfo['firstName']} ${staffInfo['lastName']}",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 28.0),
                                                    ),
                                                  ),
                                                  /* SizedBox(height: 10.0),
                                                  Align(
                                                    child: Text(
                                                      widget.lastName,
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w200),
                                                    ),
                                                  ), */
                                                  Divider(
                                                    height: 40.0,
                                                    thickness: 1.5,
                                                    indent: 32.0,
                                                    endIndent: 32.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 32.0,
                                                            right: 32.0),
                                                    child: Align(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            '${staffInfo['qualification']} | ${staffInfo['jobType']}',
                                                            //"${loggedInUser.phoneNumber} ?? '",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        82,
                                                                        95,
                                                                        127,
                                                                        1),
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200),
                                                          ),
                                                          Text(
                                                            staffInfo[
                                                                    'gender'] ??
                                                                '',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        82,
                                                                        95,
                                                                        127,
                                                                        1),
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Align(
                                                    child: Text(
                                                      'Salary: ${staffInfo['salary']}',
                                                      style: TextStyle(
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                  SizedBox(height: 25.0),
                                                  SizedBox(height: 25.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 25.0,
                                                            left: 25.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .add_shopping_cart_sharp,
                                                            color: Palette
                                                                .firebaseNavy,
                                                          ),
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SalaryAddScreen(
                                                                staffUid: staffInfo[
                                                                    'staffUid'],
                                                                staffFirstName:
                                                                    staffInfo[
                                                                            'firstName'] ??
                                                                        '',
                                                                staffLastName:
                                                                    staffInfo[
                                                                            'lastName'] ??
                                                                        '',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.edit_outlined,
                                                            color: Palette
                                                                .firebaseNavy,
                                                          ),
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  StaffEditScreen(
                                                                staffUid: widget
                                                                    .staffUid,
                                                                currentFirstName:
                                                                    staffInfo[
                                                                            'firstName'] ??
                                                                        '',
                                                                currentLastName:
                                                                    staffInfo[
                                                                            'lastName'] ??
                                                                        '',
                                                                currentQaulification:
                                                                    staffInfo[
                                                                            'qualification'] ??
                                                                        '',
                                                                currentGender:
                                                                    staffInfo[
                                                                            'gender'] ??
                                                                        '',
                                                                currentDob:
                                                                    staffInfo[
                                                                            'dob'] ??
                                                                        '',
                                                                currentJoinedDate:
                                                                    staffInfo[
                                                                            'joinedDate'] ??
                                                                        '',
                                                                currentJobType:
                                                                    staffInfo[
                                                                            'jobType'] ??
                                                                        '',
                                                                currentPictureUrl:
                                                                    staffInfo[
                                                                            'pictureUrl'] ??
                                                                        '',
                                                                currentPhone:
                                                                    staffInfo[
                                                                            'phone'] ??
                                                                        '',
                                                                currentEmail:
                                                                    staffInfo[
                                                                            'email'] ??
                                                                        '',
                                                                currentHouseNumber:
                                                                    staffInfo[
                                                                            'houseNumber'] ??
                                                                        '',
                                                                currentStreet:
                                                                    staffInfo[
                                                                            'street'] ??
                                                                        '',
                                                                currentCity:
                                                                    staffInfo[
                                                                            'city'] ??
                                                                        '',
                                                                currentState:
                                                                    staffInfo[
                                                                            'state'] ??
                                                                        '',
                                                                currentCountry:
                                                                    staffInfo[
                                                                            'country'] ??
                                                                        '',
                                                                currentTimeStamp:
                                                                    staffInfo[
                                                                            'timeSatmp'] ??
                                                                        '',
                                                                currentSalary:
                                                                    staffInfo[
                                                                            'salary'] ??
                                                                        '',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        /* IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .delete_rounded,
                                                            color: Palette
                                                                .firebaseNavy,
                                                          ),
                                                          onPressed: () async {
                                                            await StaffService(
                                                                    uid: currentUser!
                                                                        .uid)
                                                                .deleteStaff(
                                                                    staffUid:
                                                                        widget
                                                                            .staffUid);
                                                            Navigator.of(
                                                                    context)
                                                                .pop;
                                                          },
                                                        ), */
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
            );
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Palette.firebaseOrange,
              ),
            ),
          );
        },
      ),
    );
  }
}
