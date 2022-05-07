//import 'package:tradelait/salaries/screens/salary_fromStaff_add_screen.dart';
import 'package:tradelait/salaries/screens/salary_add_screen.dart';
import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/staff/screens/staff_edit_screen.dart';
import 'package:tradelait/staff/screens/staff_single_screen_2.dart';
import 'package:tradelait/widgets/custom_search_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/staff/services/staff_service.dart';

class StaffList extends StatefulWidget {
  @override
  State<StaffList> createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  TextEditingController _searchController = TextEditingController();

  CollectionReference allNoteCollection =
      FirebaseFirestore.instance.collection('staffs');

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
            hint: 'Search with staff\'s first name ',
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: StaffService(uid: currentUser!.uid).readStaff(),
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
                      //staffs = snapshot.data!.docs;
                      var staffInfo =
                          documents[index].data() as Map<String, dynamic>;
                      String staffUid = snapshot.data!.docs[index].id;
                      String firstName = staffInfo['firstName'];
                      String lastName = staffInfo['lastName'];
                      String salary = staffInfo['salary'] ?? '';
                      String qualification = staffInfo['qualification'] ?? '';
                      String gender = staffInfo['gender'] ?? '';
                      String dob = staffInfo['dob'] ?? '';
                      String joinedDate = staffInfo['joinedDate'] ?? '';
                      String jobType = staffInfo['jobType'] ?? '';
                      String pictureUrl = staffInfo['pictureUrl'] ?? '';
                      String phone = staffInfo['phone'] ?? '';
                      String email = staffInfo['email'] ?? '';
                      String houseNumber = staffInfo['houseNumber'] ?? '';
                      String street = staffInfo['street'] ?? '';
                      String city = staffInfo['city'] ?? '';
                      String state = staffInfo['state'] ?? '';
                      String country = staffInfo['country'] ?? '';
                      String timeStamp = staffInfo['timeStamp'] ?? '';

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
                              builder: (context) => StaffSingleScreen2(
                                firstName: firstName.toString(),
                                lastName: lastName.toString(),
                                staffUid: staffUid.toString(),
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
                            gender + ' ' + '|' + ' ' + qualification,
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
                                    builder: (context) => SalaryAddScreen(
                                      staffUid: staffUid,
                                      staffFirstName: firstName,
                                      staffLastName: lastName,
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
                                    builder: (context) => StaffEditScreen(
                                      staffUid: staffUid,
                                      currentFirstName: firstName,
                                      currentLastName: lastName,
                                      currentSalary: salary,
                                      currentQaulification: qualification,
                                      currentJobType: jobType,
                                      currentGender: gender,
                                      currentDob: dob,
                                      currentJoinedDate: joinedDate,
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
