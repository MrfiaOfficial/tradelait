import 'package:tradelait/students/screens/student_edit_screen.dart';
import 'package:tradelait/students/screens/unused_students/student_single_screen_2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/payments/screens/payment_fromStudent_add_screen.dart';

class StudentListWithSearch extends StatefulWidget {
  @override
  _StudentListWithSearchState createState() => _StudentListWithSearchState();
}

class _StudentListWithSearchState extends State<StudentListWithSearch> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  List allStudents = [];

  // to get the list of all students
  futureStuds() async {
    CollectionReference studentCollection =
        _userCollection.doc(currentUser!.uid).collection('students');

    final QuerySnapshot students = await studentCollection.get();
    final List<DocumentSnapshot> documents = students.docs;

    List studentList = [];
    documents.forEach((snapshot) {
      studentList.add(snapshot);
    });
    setState(() {
      allStudents = studentList;
    });
  }

  @override
  void initState() {
    super.initState();
    futureStuds();
  }

  //TextEditingController _searchController = TextEditingController();
  CollectionReference allNoteCollection =
      FirebaseFirestore.instance.collection('students');
  List<DocumentSnapshot> documents = [];

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: TextField(),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 16.0),
              itemCount: allStudents.length,
              itemBuilder: (context, index) {
                //students = snapshot.data!.docs;
                var studentInfo =
                    allStudents[index].data() as Map<String, dynamic>;
                String studentUid = allStudents[index].id;
                String firstName = studentInfo['firstName'];
                String lastName = studentInfo['lastName'];
                String studentClass = studentInfo['studentClass'] ?? '';
                String gender = studentInfo['gender'] ?? '';
                String dob = studentInfo['dob'] ?? '';
                String joinedDate = studentInfo['joinedDate'] ?? '';
                String schoolType = studentInfo['schoolType'] ?? '';
                String pictureUrl = studentInfo['pictureUrl'] ?? '';
                String phone = studentInfo['phone'] ?? '';
                String email = studentInfo['email'] ?? '';
                String houseNumber = studentInfo['houseNumber'] ?? '';
                String street = studentInfo['street'] ?? '';
                String city = studentInfo['city'] ?? '';
                String state = studentInfo['state'] ?? '';
                String country = studentInfo['country'] ?? '';
                String timeStamp = studentInfo['timeStamp'] ?? '';

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
                        builder: (context) => StudentSingleScreen2(
                          firstName: firstName.toString(),
                          lastName: lastName.toString(),
                          studentUid: studentUid.toString(),
                        ),
                      ),
                    ),
                    title: Text(
                      firstName + ' ' + lastName,
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
                      //firstName,
                      gender + ' ' + '|' + ' ' + studentClass,
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
                            Icons.add_shopping_cart_sharp,
                            color: Palette.firebaseYellow,
                          ),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PaymentAddScreenFromStudent(
                                payerUid: studentUid,
                                payerFirstName: firstName,
                                payerLastName: lastName,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit_outlined,
                            color: Palette.firebaseYellow,
                          ),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => StudentEditScreen(
                                studentUid: studentUid,
                                currentFirstName: firstName,
                                currentLastName: lastName,
                                currentStudentClass: studentClass,
                                currentGender: gender,
                                currentDob: dob,
                                currentJoinedDate: joinedDate,
                                currentSchoolType: schoolType,
                                currentPictureUrl: pictureUrl,
                                currentPhone: phone,
                                currentEmail: email,
                                currentHouseNumber: houseNumber,
                                currentStreet: street,
                                currentCity: city,
                                currentState: state,
                                currentCountry: country,
                                currentTimeStamp: timeStamp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
