import 'dart:ui';
import 'package:tradelait/payments/screens/payment_fromStudent2_list_screen.dart';
import 'package:tradelait/payments/screens/payment_fromStudent_add_screen.dart';
import 'package:tradelait/students/models/student_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/students/screens/student_edit_screen.dart';
import 'package:tradelait/students/services/student_service.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:tradelait/users/models/user_model.dart';

// ignore: must_be_immutable
class StudentSingleScreen2 extends StatefulWidget {
  final String studentUid;
  String firstName;
  String lastName;

  StudentSingleScreen2({
    Key? key,
    required this.studentUid,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  @override
  _StudentSingleScreen2State createState() => _StudentSingleScreen2State();
}

class _StudentSingleScreen2State extends State<StudentSingleScreen2> {
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
      body: StreamBuilder<StudentData>(
        stream: StudentService(uid: currentUser!.uid)
            .streamStudent(widget.studentUid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            var studentInfo = snapshot.data!;

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
                                                      '${studentInfo.firstName} ${studentInfo.lastName}',
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
                                                            '${studentInfo.studentClass} | ${studentInfo.schoolType}',
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
                                                            studentInfo
                                                                    .gender ??
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
                                                    child: TextButton(
                                                      child: Text(
                                                        'All Payments',
                                                        style: TextStyle(
                                                            fontSize: 17),
                                                      ),
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PaymentListScreenFromStudent2(
                                                            studentUid:
                                                                studentInfo
                                                                    .studentUid,
                                                            firstName:
                                                                studentInfo
                                                                    .firstName
                                                                    .toString(),
                                                            lastName:
                                                                studentInfo
                                                                    .lastName
                                                                    .toString(),
                                                          ),
                                                        ),
                                                      ),
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
                                                                  PaymentAddScreenFromStudent(
                                                                payerUid:
                                                                    studentInfo
                                                                        .studentUid,
                                                                payerFirstName:
                                                                    studentInfo
                                                                            .firstName ??
                                                                        '',
                                                                payerLastName:
                                                                    studentInfo
                                                                            .lastName ??
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
                                                                  StudentEditScreen(
                                                                studentUid: widget
                                                                    .studentUid,
                                                                currentFirstName:
                                                                    studentInfo
                                                                            .firstName ??
                                                                        '',
                                                                currentLastName:
                                                                    studentInfo
                                                                            .lastName ??
                                                                        '',
                                                                currentStudentClass:
                                                                    studentInfo
                                                                            .studentClass ??
                                                                        '',
                                                                currentGender:
                                                                    studentInfo
                                                                            .gender ??
                                                                        '',
                                                                currentDob:
                                                                    studentInfo
                                                                            .dob ??
                                                                        '',
                                                                currentJoinedDate:
                                                                    studentInfo
                                                                            .joinedDate ??
                                                                        '',
                                                                currentSchoolType:
                                                                    studentInfo
                                                                            .schoolType ??
                                                                        '',
                                                                currentPictureUrl:
                                                                    studentInfo
                                                                            .pictureUrl ??
                                                                        '',
                                                                currentPhone:
                                                                    studentInfo
                                                                            .phone ??
                                                                        '',
                                                                currentEmail:
                                                                    studentInfo
                                                                            .email ??
                                                                        '',
                                                                currentHouseNumber:
                                                                    studentInfo
                                                                            .houseNumber ??
                                                                        '',
                                                                currentStreet:
                                                                    studentInfo
                                                                            .street ??
                                                                        '',
                                                                currentCity:
                                                                    studentInfo
                                                                            .city ??
                                                                        '',
                                                                currentState:
                                                                    studentInfo
                                                                            .state ??
                                                                        '',
                                                                currentCountry:
                                                                    studentInfo
                                                                            .country ??
                                                                        '',
                                                                currentTimeStamp:
                                                                    studentInfo
                                                                            .timeStamp ??
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
                                                            await StudentService(
                                                                    uid: currentUser!
                                                                        .uid)
                                                                .deleteStudent(
                                                                    studentUid:
                                                                        widget
                                                                            .studentUid);
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
