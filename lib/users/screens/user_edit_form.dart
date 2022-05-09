import 'package:tradelait/users/services/user_service.dart';
import 'package:tradelait/widgets/custom_number_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../res/custom_colors.dart';
import '../../services/validators/db_validator.dart';
import '../../widgets/custom_form_field.dart';

class UserEditForm extends StatefulWidget {
  final FocusNode currentBrokerNameFocusNode;
  final FocusNode currentLastNameFocusNode;
  final FocusNode currentUserNameFocusNode;
  final FocusNode currentGenderFocusNode;
  final FocusNode currentPhoneFocusNode;
  final FocusNode currentEmailFocusNode;
  final FocusNode currentSchoolNameFocusNode;
  final FocusNode currentLogoUrlFocusNode;
  final FocusNode currentHouseNumberFocusNode;
  final FocusNode currentStreetFocusNode;
  final FocusNode currentCityFocusNode;
  final FocusNode currentStateFocusNode;
  final FocusNode currentCountryFocusNode;

  final String currentBrokerName;
  final String currentLastName;
  final String currentUserName;
  final String currentGender;
  final String currentPhone;
  final String currentEmail;
  final String currentSchoolName;
  final String currentLogoUrl;
  final String currentHouseNumber;
  final String currentStreet;
  final String currentCity;
  final String currentState;
  final String currentCountry;
  final String uid;

  const UserEditForm({
    required this.currentBrokerNameFocusNode,
    required this.currentLastNameFocusNode,
    required this.currentUserNameFocusNode,
    required this.currentGenderFocusNode,
    required this.currentPhoneFocusNode,
    required this.currentEmailFocusNode,
    required this.currentSchoolNameFocusNode,
    required this.currentLogoUrlFocusNode,
    required this.currentHouseNumberFocusNode,
    required this.currentStreetFocusNode,
    required this.currentCityFocusNode,
    required this.currentStateFocusNode,
    required this.currentCountryFocusNode,
    //
    required this.currentBrokerName,
    required this.currentLastName,
    required this.currentGender,
    required this.currentPhone,
    required this.currentEmail,
    required this.currentSchoolName,
    required this.currentLogoUrl,
    required this.currentHouseNumber,
    required this.currentStreet,
    required this.currentCity,
    required this.currentState,
    required this.currentCountry,
    required this.uid,
    required this.currentUserName,
  });

  @override
  _UserEditFormState createState() => _UserEditFormState();
}

class _UserEditFormState extends State<UserEditForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  late TextEditingController _brokerNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _userNameController;
  late TextEditingController _genderController;
  late TextEditingController _schoolNameController;
  late TextEditingController _logoUrlController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _houseNumberController;
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _countryController;

  @override
  void initState() {
    _brokerNameController = TextEditingController(
      text: widget.currentBrokerName,
    );

    _lastNameController = TextEditingController(
      text: widget.currentLastName,
    );

    _userNameController = TextEditingController(
      text: widget.currentUserName,
    );

    _genderController = TextEditingController(
      text: widget.currentGender,
    );

    _phoneController = TextEditingController(
      text: widget.currentPhone,
    );

    _emailController = TextEditingController(
      text: widget.currentEmail,
    );

    _logoUrlController = TextEditingController(
      text: widget.currentLogoUrl,
    );

    _schoolNameController = TextEditingController(
      text: widget.currentSchoolName,
    );

    _houseNumberController = TextEditingController(
      text: widget.currentHouseNumber,
    );

    _streetController = TextEditingController(
      text: widget.currentStreet,
    );

    _cityController = TextEditingController(
      text: widget.currentCity,
    );

    _stateController = TextEditingController(
      text: widget.currentState,
    );

    _countryController = TextEditingController(
      text: widget.currentCountry,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _editItemFormKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.0),
                  Text(
                    'First Name',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    isLabelEnabled: false,
                    controller: _brokerNameController,
                    focusNode: widget.currentBrokerNameFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'First Name',
                    hint: 'Edit the first name here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Last Name',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    //maxLines: 10,
                    isLabelEnabled: false,
                    controller: _lastNameController,
                    focusNode: widget.currentLastNameFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Last Name',
                    hint: 'Edit the last name here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'User Name',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    //maxLines: 10,
                    isLabelEnabled: false,
                    controller: _userNameController,
                    focusNode: widget.currentUserNameFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'User Name',
                    hint: 'Edit your user name here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Gender',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    //maxLines: 10,
                    isLabelEnabled: false,
                    controller: _genderController,
                    focusNode: widget.currentGenderFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Last Name',
                    hint: 'Edit the last name here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'School Name',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    //maxLines: 10,
                    isLabelEnabled: false,
                    controller: _schoolNameController,
                    focusNode: widget.currentSchoolNameFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'School Type',
                    hint: 'Edit the school type here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomNumberFormField(
                    //maxLines: 10,
                    isLabelEnabled: false,
                    controller: _phoneController,
                    focusNode: widget.currentPhoneFocusNode,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validatePhone(
                      phone: value,
                    ),
                    label: 'Phone Number',
                    hint: 'Edit the phone number here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Email Address',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    //maxLines: 10,
                    isLabelEnabled: false,
                    controller: _emailController,
                    focusNode: widget.currentEmailFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Email Address',
                    hint: 'Edit the email address here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'House Number',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    //maxLines: 10,
                    isLabelEnabled: false,
                    controller: _houseNumberController,
                    focusNode: widget.currentHouseNumberFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'House Number',
                    hint: 'Edit the house number here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Street Name',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    //maxLines: 10,
                    isLabelEnabled: false,
                    controller: _streetController,
                    focusNode: widget.currentStreetFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Street Name',
                    hint: 'Edit the street name here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'State',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    //maxLines: 10,
                    isLabelEnabled: false,
                    controller: _stateController,
                    focusNode: widget.currentStateFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Last Name',
                    hint: 'Edit the state here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Country',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    //maxLines: 10,
                    isLabelEnabled: false,
                    controller: _countryController,
                    focusNode: widget.currentCountryFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Country',
                    hint: 'Edit the country here',
                  ),
                ],
              ),
            ),
            _isProcessing
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Palette.firebaseOrange,
                      ),
                    ),
                  )
                : Container(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Palette.firebaseWhite,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        widget.currentBrokerNameFocusNode.unfocus();
                        widget.currentLastNameFocusNode.unfocus();
                        widget.currentUserNameFocusNode.unfocus();
                        widget.currentGenderFocusNode.unfocus();
                        widget.currentPhoneFocusNode.unfocus();
                        widget.currentEmailFocusNode.unfocus();
                        widget.currentSchoolNameFocusNode.unfocus();
                        widget.currentLogoUrlFocusNode.unfocus();
                        widget.currentHouseNumberFocusNode.unfocus();
                        widget.currentStreetFocusNode.unfocus();
                        widget.currentCityFocusNode.unfocus();
                        widget.currentStateFocusNode.unfocus();
                        widget.currentCountryFocusNode.unfocus();

                        if (_editItemFormKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });

                          // to get the current user uid and add the broker
                          // under his account
                          var currentUser = FirebaseAuth.instance.currentUser;
                          if (currentUser != null) {
                            await UserService(uid: currentUser.uid).updateUser(
                              brokerName: _brokerNameController.text,
                              lastName: _lastNameController.text,
                              userName: _userNameController.text,
                              gender: _genderController.text,
                              schoolName: _schoolNameController.text,
                              logoUrl: _logoUrlController.text,
                              phone: _phoneController.text,
                              email: _emailController.text,
                              houseNumber: _houseNumberController.text,
                              street: _streetController.text,
                              city: _cityController.text,
                              state: _stateController.text,
                              country: _countryController.text,
                            );
                          }

                          setState(() {
                            _isProcessing = false;
                          });

                          Navigator.of(context).pop();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'UPDATE PROFILE',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Palette.firebaseNavy,
                            letterSpacing: 2,
                          ),
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
