import 'package:tradelait/payments/screens/payment_fromStudent_add_screen.dart';
import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/students/screens/student_edit_screen.dart';
import 'package:tradelait/students/screens/unused_students/student_single_screen_2.dart';
import 'package:tradelait/students/screens/student_single_screen.dart';
import 'package:tradelait/widgets/custom_search_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/students/services/student_service.dart';

class StudentList extends StatefulWidget {
  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  TextEditingController _searchController = TextEditingController();

  CollectionReference allNoteCollection =
      FirebaseFirestore.instance.collection('students');

  List<DocumentSnapshot> documents = [];

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    return Container(
      child: Column(
        children: [
          CustomSearchFormField(
            isLabelEnabled: false,
            controller: _searchController,
            keyboardType: TextInputType.text,
            inputAction: TextInputAction.next,
            validator: (value) => DbValidator.validateField(
              value: value,
            ),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            label: 'Search',
            hint: 'Search with student\'s first name ',
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: StudentService(uid: currentUser!.uid).readStudents(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                } else if (snapshot.hasData || snapshot.data != null) {
                  documents = snapshot.data!.docs;
                  if (searchText.length > 0) {
                    documents = documents.where((element) {
                      return element
                          .get('firstName')
                          .toString()
                          .toLowerCase()
                          .contains(searchText.toLowerCase());
                    }).toList();
                  }
                  return ListView.separated(
                    reverse: false,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.0),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      //students = snapshot.data!.docs;
                      var studentInfo =
                          documents[index].data() as Map<String, dynamic>;
                      String studentUid = snapshot.data!.docs[index].id;
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
                          /* onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => StudentSingleScreen2(
                                firstName: firstName.toString(),
                                lastName: lastName.toString(),
                                studentUid: studentUid.toString(),
                              ),
                            ),
                          ), */
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => StudentSingleScreen(
                                firstName: firstName.toString(),
                                lastName: lastName.toString(),
                                studentUid: studentUid.toString(),
                                studentClass: studentClass,
                                gender: gender,
                                dob: dob,
                                joinedDate: joinedDate,
                                schoolType: schoolType,
                                pictureUrl: pictureUrl,
                                phone: phone,
                                email: email,
                                houseNumber: houseNumber,
                                street: street,
                                city: city,
                                state: state,
                                country: country,
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
                                    fontSize: 40,
                                    color: Palette.firebaseOrange),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add_shopping_cart_sharp,
                                  color: Palette.firebaseYellow,
                                ),
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PaymentAddScreenFromStudent(
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
          ),
        ],
      ),
    );
  }
}
