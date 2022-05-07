import 'package:tradelait/staff/services/staff_service.dart';
import 'package:tradelait/widgets/custom_number_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/widgets/custom_form_field.dart';
import 'package:intl/intl.dart';

class StaffAddForm extends StatefulWidget {
  final FocusNode firstNameFocusNode;
  final FocusNode lastNameFocusNode;
  final FocusNode salaryFocusNode;
  final FocusNode phoneFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode joinedDateFocusNode;
  final FocusNode dobFocusNode;
  final FocusNode pictureUrlFocusNode;
  final FocusNode houseNumberFocusNode;
  final FocusNode streetFocusNode;
  final FocusNode cityFocusNode;
  final FocusNode stateFocusNode;
  final FocusNode countryFocusNode;

  const StaffAddForm({
    required this.firstNameFocusNode,
    required this.lastNameFocusNode,
    required this.salaryFocusNode,
    required this.dobFocusNode,
    required this.phoneFocusNode,
    required this.emailFocusNode,
    required this.joinedDateFocusNode,
    required this.pictureUrlFocusNode,
    required this.houseNumberFocusNode,
    required this.streetFocusNode,
    required this.cityFocusNode,
    required this.stateFocusNode,
    required this.countryFocusNode,
  });

  @override
  _StaffAddFormState createState() => _StaffAddFormState();
}

class _StaffAddFormState extends State<StaffAddForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _joinedDateController = TextEditingController();
  final TextEditingController _pictureUrlController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  //
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool _isProcessing = false;
  String _customStaffUid = '';
  String _gender = 'Male';
  String _jobType = 'Teacher';
  String _qualification = 'BSc. (Edu)';

  //
  @override
  void initState() {
    _dobController.text =
        new DateTime.now().toString().split(" ")[0].toString();
    _joinedDateController.text =
        new DateTime.now().toString().split(" ")[0].toString();
    super.initState();
  }

  getCustomStaffUid() {
    var firstName = _firstNameController.text;
    var lastName = _lastNameController.text;
    var fullName = firstName.toString().toLowerCase().trim() +
        lastName.toString().toLowerCase().trim();

    var year = DateTime.now().year.toString();
    var month = DateTime.now().month.toString();
    var day = DateTime.now().day.toString();

    var hour = DateTime.now().hour.toString();
    var mlsecond = DateTime.now().millisecond.toString();
    var misecond = DateTime.now().microsecond.toString();

    var dateStamp = year + month + day;
    var timeStamp = hour + mlsecond + misecond;
    var dateTime = dateStamp + timeStamp;
    var customStaffUid = fullName.substring(0, 6) + dateTime.substring(0, 13);

    setState(() {
      _customStaffUid = customStaffUid;
    });
    return print(customStaffUid);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _addItemFormKey,
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
                    focusNode: widget.firstNameFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'First Name',
                    hint: 'Enter staff first name',
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
                    isLabelEnabled: false,
                    controller: _lastNameController,
                    focusNode: widget.lastNameFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Last Name',
                    hint: 'Enter staff last name',
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
                    'School Type',
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
                    'Profile Picture Url',
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
                    controller: _pictureUrlController,
                    focusNode: widget.pictureUrlFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Profile Picture Url',
                    hint: 'Enter staff\'s profile picture url',
                  ),
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
                    isLabelEnabled: false,
                    controller: _salaryController,
                    focusNode: widget.salaryFocusNode,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Salary',
                    hint: 'Enter staff\'s salary here',
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
                    isLabelEnabled: false,
                    controller: _phoneController,
                    focusNode: widget.phoneFocusNode,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Contact Phone',
                    hint: 'Enter staff\'s contact phone',
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
                    isLabelEnabled: false,
                    controller: _emailController,
                    focusNode: widget.emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Contact',
                    hint: 'Enter staff\'s contact email',
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
                    isLabelEnabled: false,
                    controller: _houseNumberController,
                    focusNode: widget.houseNumberFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'House Number',
                    hint: 'Enter staff\'s address house number',
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
                    isLabelEnabled: false,
                    controller: _streetController,
                    focusNode: widget.streetFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Street Name',
                    hint: 'Enter staff\'s address street name',
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
                    isLabelEnabled: false,
                    controller: _cityController,
                    focusNode: widget.cityFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'City',
                    hint: 'Enter staff\'s address city',
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
                    isLabelEnabled: false,
                    controller: _stateController,
                    focusNode: widget.stateFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'State',
                    hint: 'Enter staff\'s state',
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
                    isLabelEnabled: false,
                    controller: _countryController,
                    focusNode: widget.countryFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Country',
                    hint: 'Enter staff\'s country',
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
                        widget.firstNameFocusNode.unfocus();
                        widget.lastNameFocusNode.unfocus();
                        widget.salaryFocusNode.unfocus();
                        widget.dobFocusNode.unfocus();
                        widget.phoneFocusNode.unfocus();
                        widget.emailFocusNode.unfocus();
                        widget.joinedDateFocusNode.unfocus();
                        widget.pictureUrlFocusNode.unfocus();
                        widget.houseNumberFocusNode.unfocus();
                        widget.streetFocusNode.unfocus();
                        widget.cityFocusNode.unfocus();
                        widget.stateFocusNode.unfocus();
                        widget.countryFocusNode.unfocus();

                        // Call the function that set the _customStaffUid parameter
                        getCustomStaffUid();

                        if (_addItemFormKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });

                          await StaffService(uid: currentUser!.uid).addStaff(
                            staffUid: _customStaffUid,
                            firstName: _firstNameController.text.trim(),
                            lastName: _lastNameController.text.trim(),
                            jobType: _jobType,
                            qualification: _qualification,
                            salary: _salaryController.text.trim(),
                            gender: _gender,
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
                            timeStamp: new DateTime.now().toString(),
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
                          'ADD STAFF',
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

  // Date Of Birth
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
              initialDate: DateTime(2020),
              firstDate: DateTime.parse('1950-01-01'),
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
