import 'package:tradelait/students/screens/student_edit_form.dart';
import 'package:tradelait/students/services/student_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../res/custom_colors.dart';
import '../../widgets/app_bar_title.dart';

class StudentEditScreen extends StatefulWidget {
  final String currentFirstName;
  final String currentLastName;
  final String currentStudentClass;
  final String currentGender;
  final String currentDob;
  final String currentSchoolType;
  final String currentJoinedDate;
  final String currentPictureUrl;
  final String currentPhone;
  final String currentEmail;
  final String currentHouseNumber;
  final String currentStreet;
  final String currentCity;
  final String currentState;
  final String currentCountry;
  final String currentTimeStamp;
  final String studentUid;

  StudentEditScreen({
    required this.currentFirstName,
    required this.currentLastName,
    required this.currentStudentClass,
    required this.currentGender,
    required this.currentPhone,
    required this.currentEmail,
    required this.currentJoinedDate,
    required this.currentDob,
    required this.currentSchoolType,
    required this.currentPictureUrl,
    required this.currentHouseNumber,
    required this.currentStreet,
    required this.currentCity,
    required this.currentState,
    required this.currentCountry,
    required this.currentTimeStamp,
    required this.studentUid,
  });

  @override
  _StudentEditScreenState createState() => _StudentEditScreenState();
}

class _StudentEditScreenState extends State<StudentEditScreen> {
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _dobFocusNode = FocusNode();
  final FocusNode _joinedDateFocusNode = FocusNode();
  final FocusNode _pictureUrlFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _houseNumberFocusNode = FocusNode();
  final FocusNode _streetFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _stateFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();

  bool _isDeleting = false;
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _firstNameFocusNode.unfocus();
          _lastNameFocusNode.unfocus();
          _dobFocusNode.unfocus();
          _phoneFocusNode.unfocus();
          _emailFocusNode.unfocus();
          _joinedDateFocusNode.unfocus();
          _pictureUrlFocusNode.unfocus();
          _houseNumberFocusNode.unfocus();
          _streetFocusNode.unfocus();
          _cityFocusNode.unfocus();
          _stateFocusNode.unfocus();
          _countryFocusNode.unfocus();
        },
        child: Scaffold(
          backgroundColor: Palette.firebaseNavy,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Palette.firebaseNavy,
            title: AppBarTitle(
                sectionName: 'Edit : ' +
                    widget.currentFirstName +
                    ' ' +
                    widget.currentLastName),
            actions: [
              _isDeleting
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        right: 16.0,
                      ),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.redAccent,
                        ),
                        strokeWidth: 3,
                      ),
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                        size: 32,
                      ),
                      onPressed: () async {
                        setState(() {
                          _isDeleting = true;
                        });

                        await StudentService(uid: currentUser!.uid)
                            .deleteStudent(
                          studentUid: widget.studentUid,
                        );

                        setState(() {
                          _isDeleting = false;
                        });

                        Navigator.of(context).pop();
                      },
                    ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 20.0,
              ),
              child: StudentEditForm(
                currentFirstNameFocusNode: _firstNameFocusNode,
                currentLastNameFocusNode: _lastNameFocusNode,
                currentDobFocusNode: _dobFocusNode,
                currentJoinedDateFocusNode: _joinedDateFocusNode,
                currentPictureUrlFocusNode: _pictureUrlFocusNode,
                currentPhoneFocusNode: _phoneFocusNode,
                currentEmailFocusNode: _emailFocusNode,
                currentHouseNumberFocusNode: _houseNumberFocusNode,
                currentStreetFocusNode: _houseNumberFocusNode,
                currentCityFocusNode: _cityFocusNode,
                currentStateFocusNode: _stateFocusNode,
                currentCountryFocusNode: _countryFocusNode,
                //
                studentUid: widget.studentUid,
                currentFirstName: widget.currentFirstName,
                currentLastName: widget.currentLastName,
                currentStudentClass: widget.currentStudentClass,
                currentGender: widget.currentGender,
                currentDob: widget.currentDob,
                currentJoinedDate: widget.currentJoinedDate,
                currentSchoolType: widget.currentSchoolType,
                currentPictureUrl: widget.currentPictureUrl,
                currentPhone: widget.currentPhone,
                currentEmail: widget.currentEmail,
                currentHouseNumber: widget.currentHouseNumber,
                currentStreet: widget.currentStreet,
                currentCity: widget.currentCity,
                currentState: widget.currentState,
                currentCountry: widget.currentCountry,
                currentTimeStamp: widget.currentTimeStamp,
              ),
            ),
          ),
        ));
  }
}
