import 'package:tradelait/staff/services/staff_service.dart';
import 'package:tradelait/widgets/custom_number_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/widgets/custom_form_field.dart';
import 'package:intl/intl.dart';

class StaffEditForm extends StatefulWidget {
  final FocusNode currentFirstNameFocusNode;
  final FocusNode currentLastNameFocusNode;
  final FocusNode currentSalaryFocusNode;
  final FocusNode currentPhoneFocusNode;
  final FocusNode currentEmailFocusNode;
  final FocusNode currentJoinedDateFocusNode;
  final FocusNode currentDobFocusNode;
  final FocusNode currentPictureUrlFocusNode;
  final FocusNode currentHouseNumberFocusNode;
  final FocusNode currentStreetFocusNode;
  final FocusNode currentCityFocusNode;
  final FocusNode currentStateFocusNode;
  final FocusNode currentCountryFocusNode;

  final String currentFirstName;
  final String currentLastName;
  final String currentSalary;
  final String currentQualification;
  final String currentJobType;
  final String currentGender;
  final String currentPhone;
  final String currentEmail;
  final String currentJoinedDate;
  final String currentDob;
  final String currentPictureUrl;
  final String currentHouseNumber;
  final String currentStreet;
  final String currentCity;
  final String currentState;
  final String currentCountry;
  final String currentTimeStamp;
  final String staffUid;

  const StaffEditForm({
    required this.currentFirstNameFocusNode,
    required this.currentLastNameFocusNode,
    required this.currentPhoneFocusNode,
    required this.currentEmailFocusNode,
    required this.currentJoinedDateFocusNode,
    required this.currentDobFocusNode,
    required this.currentPictureUrlFocusNode,
    required this.currentHouseNumberFocusNode,
    required this.currentStreetFocusNode,
    required this.currentCityFocusNode,
    required this.currentStateFocusNode,
    required this.currentCountryFocusNode,
    //
    required this.currentFirstName,
    required this.currentLastName,
    required this.currentSalary,
    required this.currentQualification,
    required this.currentJobType,
    required this.currentGender,
    required this.currentPhone,
    required this.currentEmail,
    required this.currentJoinedDate,
    required this.currentDob,
    required this.currentPictureUrl,
    required this.currentHouseNumber,
    required this.currentStreet,
    required this.currentCity,
    required this.currentState,
    required this.currentCountry,
    required this.currentTimeStamp,
    required this.staffUid,
    required this.currentSalaryFocusNode,
  });

  @override
  _StaffEditFormState createState() => _StaffEditFormState();
}

class _StaffEditFormState extends State<StaffEditForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _salaryController;
  late TextEditingController _dobController;
  late TextEditingController _joinedDateController;
  late TextEditingController _pictureUrlController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _houseNumberController;
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _countryController;

  //
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool _isProcessing = false;
  String _gender = 'Male';
  String _jobType = 'Teacher';
  String _qualification = 'Bsc. (Edu)';

  //

  @override
  void initState() {
    _firstNameController = TextEditingController(
      text: widget.currentFirstName,
    );

    _lastNameController = TextEditingController(
      text: widget.currentLastName,
    );

    _salaryController = TextEditingController(
      text: widget.currentSalary,
    );

    _qualification = widget.currentQualification;
    _gender = widget.currentGender;
    _jobType = widget.currentJobType;

    _dobController = TextEditingController(
      text: widget.currentDob,
    );

    _joinedDateController = TextEditingController(
      text: widget.currentJoinedDate,
    );

    _phoneController = TextEditingController(
      text: widget.currentPhone,
    );

    _emailController = TextEditingController(
      text: widget.currentEmail,
    );

    _pictureUrlController = TextEditingController(
      text: widget.currentPictureUrl,
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
                    controller: _firstNameController,
                    focusNode: widget.currentFirstNameFocusNode,
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
                    'Class',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  BuildQualification(),
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
                  BuildGender(),
                  SizedBox(height: 24.0),
                  Text(
                    'Job Type',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  BuildJobType(),
                  SizedBox(height: 24.0),
                  Text(
                    'Date Of Birth',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  BuildDob(),
                  SizedBox(height: 24.0),
                  Text(
                    'Joined Date',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  BuildJoinedDate(),
                  SizedBox(height: 24.0),
                  Text(
                    'Salary',
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
                    controller: _salaryController,
                    focusNode: widget.currentSalaryFocusNode,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Salary',
                    hint: 'Edit the salary here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Contact Phone',
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
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Contact Phone',
                    hint: 'Edit the contact phone here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Contact Email',
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
                    label: 'Contact Email',
                    hint: 'Edit the contact email here',
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
                    'City',
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
                    controller: _cityController,
                    focusNode: widget.currentCityFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'City',
                    hint: 'Edit the city here',
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
                    label: 'State',
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
                        widget.currentFirstNameFocusNode.unfocus();
                        widget.currentLastNameFocusNode.unfocus();
                        widget.currentSalaryFocusNode.unfocus();
                        widget.currentDobFocusNode.unfocus();
                        widget.currentPhoneFocusNode.unfocus();
                        widget.currentEmailFocusNode.unfocus();
                        widget.currentJoinedDateFocusNode.unfocus();
                        widget.currentPictureUrlFocusNode.unfocus();
                        widget.currentHouseNumberFocusNode.unfocus();
                        widget.currentStreetFocusNode.unfocus();
                        widget.currentCityFocusNode.unfocus();
                        widget.currentStateFocusNode.unfocus();
                        widget.currentCountryFocusNode.unfocus();

                        if (_editItemFormKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });

                          await StaffService(uid: currentUser!.uid).updateStaff(
                            staffUid: widget.staffUid,
                            firstName: _firstNameController.text.trim(),
                            lastName: _lastNameController.text.trim(),
                            salary: _salaryController.text.trim(),
                            qualification: _qualification,
                            gender: _gender,
                            jobType: _jobType,
                            dob: _dobController.text,
                            joinedDate: _joinedDateController.text,
                            pictureUrl: _pictureUrlController.text.trim(),
                            phone: _phoneController.text.trim(),
                            email: _emailController.text.trim(),
                            houseNumber: _houseNumberController.text.trim(),
                            street: _streetController.text.trim(),
                            city: _cityController.text.trim(),
                            state: _stateController.text.trim(),
                            country: _countryController.text.trim(),
                            timeStamp: widget.currentTimeStamp,
                          );
                        }

                        setState(() {
                          _isProcessing = false;
                        });

                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'UPDATE STAFF',
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

  //
  List<String> genders = [
    'Male',
    'Female',
  ];
  Widget BuildGender() => DropdownButtonFormField<String?>(
        iconDisabledColor: Palette.firebaseYellow,
        iconEnabledColor: Palette.firebaseYellow,
        decoration: InputDecoration(
          filled: true,
          fillColor: Palette.firebaseYellow,
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: Palette.firebaseNavy,
            size: 25,
          ),
          labelStyle: TextStyle(color: Palette.firebaseYellow, fontSize: 16),
          hintStyle: TextStyle(
            color: Palette.firebaseGrey.withOpacity(0.5),
          ),
          errorStyle: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Palette.firebaseAmber,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Palette.firebaseGrey.withOpacity(0.5),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
          ),
        ),
        style: TextStyle(color: Palette.firebaseNavy, fontSize: 15),
        value: _gender,
        items: genders.map((gender) {
          return DropdownMenuItem(
            value: gender,
            child: Text('$gender'),
          );
        }).toList(),
        onChanged: (String? val) => setState(() => _gender = val!),
      );

  //
  List<String> jobTypes = [
    'Teacher',
    'Admin',
    'Bursar',
    'Accountant',
    'H.O.D',
    'Sport Instructor',
    'Driver',
    'Cleaner',
    'Hostel Master',
    'Cook',
    'Personal Assistant',
    'Technician',
    'Gardener',
    'Others',
  ];
  Widget BuildJobType() => DropdownButtonFormField<String?>(
        iconDisabledColor: Palette.firebaseYellow,
        iconEnabledColor: Palette.firebaseYellow,
        decoration: InputDecoration(
          filled: true,
          fillColor: Palette.firebaseYellow,
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: Palette.firebaseNavy,
            size: 25,
          ),
          labelStyle: TextStyle(color: Palette.firebaseYellow, fontSize: 16),
          hintStyle: TextStyle(
            color: Palette.firebaseGrey.withOpacity(0.5),
          ),
          errorStyle: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Palette.firebaseAmber,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Palette.firebaseGrey.withOpacity(0.5),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
          ),
        ),
        style: TextStyle(color: Palette.firebaseNavy, fontSize: 15),
        value: _jobType,
        items: jobTypes.map((jobType) {
          return DropdownMenuItem(
            value: jobType,
            child: Text('$jobType'),
          );
        }).toList(),
        onChanged: (String? val) => setState(() => _jobType = val!),
      );

  //
  List<String> qualifications = [
    'SSCE',
    'OND',
    'BSc. (Edu)',
    'BSc.',
    'HND',
    'PGDE',
    'Msc.',
    'MBA',
    'PhD',
    'Others',
  ];
  Widget BuildQualification() => DropdownButtonFormField<String?>(
        iconDisabledColor: Palette.firebaseYellow,
        iconEnabledColor: Palette.firebaseYellow,
        decoration: InputDecoration(
          filled: true,
          fillColor: Palette.firebaseYellow,
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: Palette.firebaseNavy,
            size: 25,
          ),
          labelStyle: TextStyle(color: Palette.firebaseYellow, fontSize: 16),
          hintStyle: TextStyle(
            color: Palette.firebaseGrey.withOpacity(0.5),
          ),
          errorStyle: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Palette.firebaseAmber,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Palette.firebaseGrey.withOpacity(0.5),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
          ),
        ),
        style: TextStyle(color: Palette.firebaseNavy, fontSize: 15),
        value: _qualification,
        items: qualifications.map((qualification) {
          return DropdownMenuItem(
            value: qualification,
            child: Text('$qualification'),
          );
        }).toList(),
        onChanged: (String? val) => setState(() => _qualification = val!),
      );

  //
  Widget BuildDob() => TextField(
        controller: _dobController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Palette.firebaseYellow,
          suffixIcon: Icon(
            Icons.calendar_today,
            color: Palette.firebaseNavy,
            size: 25,
          ),
          hintText: 'Select Date',
          labelStyle: TextStyle(color: Palette.firebaseYellow, fontSize: 16),
          hintStyle: TextStyle(
            color: Palette.firebaseNavy,
          ),
          errorStyle: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Palette.firebaseAmber,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Palette.firebaseGrey.withOpacity(0.5),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
          ),
        ),
        style: TextStyle(color: Palette.firebaseNavy, fontSize: 15),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.parse('1980-01-01'),
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

            setState(() {
              _dobController.text = formattedDate;
            });
          }
        },
      );

  // Joined Date
  Widget BuildJoinedDate() => TextField(
        controller: _joinedDateController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Palette.firebaseYellow,
          suffixIcon: Icon(
            Icons.calendar_today,
            color: Palette.firebaseNavy,
            size: 25,
          ),
          hintText: 'Select Date',
          labelStyle: TextStyle(color: Palette.firebaseYellow, fontSize: 16),
          hintStyle: TextStyle(
            color: Palette.firebaseNavy,
          ),
          errorStyle: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Palette.firebaseAmber,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Palette.firebaseGrey.withOpacity(0.5),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2,
            ),
          ),
        ),
        style: TextStyle(color: Palette.firebaseNavy, fontSize: 15),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.parse('1980-01-01'),
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

            setState(() {
              _joinedDateController.text = formattedDate;
            });
          }
        },
      );
}
