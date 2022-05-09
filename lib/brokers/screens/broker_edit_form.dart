import 'package:tradelait/brokers/services/broker_service.dart';
import 'package:tradelait/widgets/custom_number_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/widgets/custom_form_field.dart';
import 'package:intl/intl.dart';

class brokerEditForm extends StatefulWidget {
  final FocusNode currentBrokerNameFocusNode;
  final FocusNode currentPhoneFocusNode;
  final FocusNode currentEmailFocusNode;
  final FocusNode currentJoinedDateFocusNode;
  final FocusNode currentLogoUrlFocusNode;
  final FocusNode currentCountryFocusNode;

  final String currentBrokerName;
  final String currentBrokerType;
  final String currentPhone;
  final String currentEmail;
  final String currentJoinedDate;
  final String currentLogoUrl;
  final String currentCountry;
  final String currentTimeStamp;
  final String brokerUid;

  const BrokerEditForm({
    required this.currentBrokerNameFocusNode,
    required this.currentPhoneFocusNode,
    required this.currentEmailFocusNode,
    required this.currentJoinedDateFocusNode,
    required this.currentLogoUrlFocusNode,
    required this.currentCountryFocusNode,
    //
    required this.currentBrokerName,
    required this.currentbrokerType,
    required this.currentPhone,
    required this.currentEmail,
    required this.currentJoinedDate,
    required this.currentLogoUrl,
    required this.currentCountry,
    required this.currentTimeStamp,
    required this.brokerUid,
  });

  @override
  _brokerEditFormState createState() => _brokerEditFormState();
}

class _brokerEditFormState extends State<brokerEditForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  late TextEditingController _brokerNameController;
  late TextEditingController _joinedDateController;
  late TextEditingController _logoUrlController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _countryController;

  //
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool _isProcessing = false;
  String _gender = 'Male';
  String _schoolType = 'Day';
  String _brokerType = 'Primary 1';

  //

  @override
  void initState() {
    _brokerNameController = TextEditingController(
      text: widget.currentBrokerName,
    );

    _lastNameController = TextEditingController(
      text: widget.currentLastName,
    );

    _brokerType = widget.currentbrokerType;
    _gender = widget.currentGender;
    _schoolType = widget.currentSchoolType;

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

    _logoUrlController = TextEditingController(
      text: widget.currentLogoUrl,
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
                    'Class',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  BuildbrokerType(),
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
                  BuildSchoolType(),
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
                        widget.currentBrokerNameFocusNode.unfocus();
                        widget.currentPhoneFocusNode.unfocus();
                        widget.currentEmailFocusNode.unfocus();
                        widget.currentJoinedDateFocusNode.unfocus();
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

                          await BrokerService(uid: currentUser!.uid)
                              .updateBroker(
                            //brokerUid: currentbroker.id,
                            brokerUid: widget.brokerUid,
                            brokerName: _brokerNameController.text.trim(),
                            brokerType: _brokerType,
                            joinedDate: _joinedDateController.text,
                            logoUrl: _logoUrlController.text.trim(),
                            phone: _phoneController.text.trim(),
                            email: _emailController.text.trim(),
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
                          'UPDATE broker',
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
  List<String> schoolTypes = [
    'Day',
    'Boarding',
  ];
  Widget BuildSchoolType() => DropdownButtonFormField<String?>(
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
        value: _schoolType,
        items: schoolTypes.map((schoolType) {
          return DropdownMenuItem(
            value: schoolType,
            child: Text('$schoolType'),
          );
        }).toList(),
        onChanged: (String? val) => setState(() => _schoolType = val!),
      );

  //
  List<String> brokerTypees = [
    'Forex',
    'Crypto',
    'Stocks',
    'Binary Options',
    'Others'
  ];
  Widget BuildbrokerType() => DropdownButtonFormField<String?>(
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
        value: _brokerType,
        items: brokerTypees.map((brokerType) {
          return DropdownMenuItem(
            value: brokerType,
            child: Text('$brokerType'),
          );
        }).toList(),
        onChanged: (String? val) => setState(() => _brokerType = val!),
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
