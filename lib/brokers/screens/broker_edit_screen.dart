import 'package:tradelait/brokers/screens/broker_edit_form.dart';
import 'package:tradelait/brokers/services/broker_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../res/custom_colors.dart';
import '../../widgets/app_bar_title.dart';

class brokerEditScreen extends StatefulWidget {
  final String currentBrokerName;
  final String currentLastName;
  final String currentbrokerType;
  final String currentGender;
  final String currentDob;
  final String currentSchoolType;
  final String currentJoinedDate;
  final String currentLogoUrl;
  final String currentPhone;
  final String currentEmail;
  final String currentHouseNumber;
  final String currentStreet;
  final String currentCity;
  final String currentState;
  final String currentCountry;
  final String currentTimeStamp;
  final String brokerUid;

  brokerEditScreen({
    required this.currentBrokerName,
    required this.currentLastName,
    required this.currentbrokerType,
    required this.currentGender,
    required this.currentPhone,
    required this.currentEmail,
    required this.currentJoinedDate,
    required this.currentDob,
    required this.currentSchoolType,
    required this.currentLogoUrl,
    required this.currentHouseNumber,
    required this.currentStreet,
    required this.currentCity,
    required this.currentState,
    required this.currentCountry,
    required this.currentTimeStamp,
    required this.brokerUid,
  });

  @override
  _brokerEditScreenState createState() => _brokerEditScreenState();
}

class _brokerEditScreenState extends State<brokerEditScreen> {
  final FocusNode _brokerNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _dobFocusNode = FocusNode();
  final FocusNode _joinedDateFocusNode = FocusNode();
  final FocusNode _logoUrlFocusNode = FocusNode();
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
          _brokerNameFocusNode.unfocus();
          _lastNameFocusNode.unfocus();
          _dobFocusNode.unfocus();
          _phoneFocusNode.unfocus();
          _emailFocusNode.unfocus();
          _joinedDateFocusNode.unfocus();
          _logoUrlFocusNode.unfocus();
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
                    widget.currentBrokerName +
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

                        await BrokerService(uid: currentUser!.uid).deleteBroker(
                          brokerUid: widget.brokerUid,
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
              child: brokerEditForm(
                currentBrokerNameFocusNode: _brokerNameFocusNode,
                currentLastNameFocusNode: _lastNameFocusNode,
                currentDobFocusNode: _dobFocusNode,
                currentJoinedDateFocusNode: _joinedDateFocusNode,
                currentLogoUrlFocusNode: _logoUrlFocusNode,
                currentPhoneFocusNode: _phoneFocusNode,
                currentEmailFocusNode: _emailFocusNode,
                currentHouseNumberFocusNode: _houseNumberFocusNode,
                currentStreetFocusNode: _houseNumberFocusNode,
                currentCityFocusNode: _cityFocusNode,
                currentStateFocusNode: _stateFocusNode,
                currentCountryFocusNode: _countryFocusNode,
                //
                brokerUid: widget.brokerUid,
                currentBrokerName: widget.currentBrokerName,
                currentLastName: widget.currentLastName,
                currentbrokerType: widget.currentbrokerType,
                currentGender: widget.currentGender,
                currentDob: widget.currentDob,
                currentJoinedDate: widget.currentJoinedDate,
                currentSchoolType: widget.currentSchoolType,
                currentLogoUrl: widget.currentLogoUrl,
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
