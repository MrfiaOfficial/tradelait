import 'package:tradelait/students/models/student_model.dart';
import 'package:tradelait/students/screens/unused_students/student_2_list_widget.dart';
import 'package:tradelait/students/services/student_service.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:tradelait/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../res/custom_colors.dart';

import '../student_add_screen.dart';

class StudentListScreen2 extends StatefulWidget {
  @override
  _StudentListScreen2State createState() => _StudentListScreen2State();
}

class _StudentListScreen2State extends State<StudentListScreen2> {
  /* final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode(); */

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return StreamProvider<List<StudentData>>.value(
      value: StudentService(uid: currentUser?.uid).streamStudentsList(),
      initialData: [], //StudentData.initialData(),
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(
            sectionName: 'Student List',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => StudentAddScreen(),
              ),
            );
          },
          backgroundColor: Palette.firebaseOrange,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
        ),
        drawer: ArgonDrawer(currentPage: "Student List"),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: StudentList2(),
          ),
        ),
      ),
    );
  }
}
