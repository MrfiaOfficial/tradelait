import 'package:tradelait/students/models/student_model.dart';
import 'package:tradelait/students/screens/unused_students/student_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../res/custom_colors.dart';

class StudentList2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<StudentData> studentList = Provider.of<List<StudentData>>(context);
    // ignore: unnecessary_null_comparison
    if (studentList != null) {
      return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 16.0),
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          return StudentTile(student: studentList[index]);
        },
      );
    }

    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Palette.firebaseOrange,
        ),
      ),
    );
  }
}





/* class StudentList2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final studentList = Provider.of<List<StudentData?>>(context);
    if (studentList != null) {
      return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 16.0),
        itemCount: studentList.length,
        itemBuilder: (context, index) {
          return StudentTile(student: studentList[index]);
        },
      );
    }

    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Palette.firebaseOrange,
        ),
      ),
    );
  }
} */
