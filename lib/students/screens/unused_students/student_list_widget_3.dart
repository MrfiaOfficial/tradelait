import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/students/models/student_model.dart';
import 'package:tradelait/students/screens/student_edit_screen.dart';
import 'package:tradelait/students/screens/student_single_screen.dart';
import 'package:tradelait/students/services/student_service.dart';

class StudentList3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    return StreamBuilder<List<StudentData>>(
      stream: StudentService(uid: currentUser?.uid).streamStudentsList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('widget3: ${snapshot.error.toString()}');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              //students = snapshot.data!.docs;
              var studentInfo = snapshot.data![index];

              return Ink(
                decoration: BoxDecoration(
                  color: Palette.firebaseGrey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StudentSingleScreen(
                        firstName: studentInfo.firstName.toString(),
                        lastName: studentInfo.lastName.toString(),
                        studentUid: studentInfo.studentUid.toString(),
                        studentClass: studentInfo.studentClass.toString(),
                        gender: studentInfo.gender.toString(),
                        dob: studentInfo.dob.toString(),
                        joinedDate: studentInfo.joinedDate.toString(),
                        schoolType: studentInfo.schoolType.toString(),
                        pictureUrl: studentInfo.pictureUrl.toString(),
                        phone: studentInfo.phone.toString(),
                        email: studentInfo.email.toString(),
                        houseNumber: studentInfo.houseNumber.toString(),
                        street: studentInfo.street.toString(),
                        city: studentInfo.city.toString(),
                        state: studentInfo.state.toString(),
                        country: studentInfo.country.toString(),
                      ),
                    ),
                  ),
                  title: Text(
                    '${studentInfo.firstName} + ' ' + ${studentInfo.lastName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      //fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  subtitle: Text(
                    '${studentInfo.gender} +  |  + ${studentInfo.studentClass}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      //fontSize: 24,
                      //fontWeight: FontWeight.bold,
                      color: Palette.firebaseGrey,
                      letterSpacing: 2,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '|',
                        style: TextStyle(
                            fontSize: 40, color: Palette.firebaseOrange),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Palette.firebaseYellow,
                        ),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StudentEditScreen(
                              studentUid: studentInfo.studentUid,
                              currentFirstName: studentInfo.firstName ?? '',
                              currentLastName: studentInfo.lastName.toString(),
                              currentStudentClass:
                                  studentInfo.studentClass.toString(),
                              currentGender: studentInfo.gender.toString(),
                              currentDob: studentInfo.dob.toString(),
                              currentJoinedDate:
                                  studentInfo.joinedDate.toString(),
                              currentSchoolType:
                                  studentInfo.schoolType.toString(),
                              currentPictureUrl:
                                  studentInfo.pictureUrl.toString(),
                              currentPhone: studentInfo.phone.toString(),
                              currentEmail: studentInfo.email.toString(),
                              currentHouseNumber:
                                  studentInfo.houseNumber.toString(),
                              currentStreet: studentInfo.street.toString(),
                              currentCity: studentInfo.city.toString(),
                              currentState: studentInfo.state.toString(),
                              currentCountry: studentInfo.country.toString(),
                              currentTimeStamp: studentInfo.timeStamp ?? '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
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
      },
    );
  }
}
