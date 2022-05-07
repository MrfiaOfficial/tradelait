import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:tradelait/staff/screens/staff_add_form.dart';

class StaffAddScreen extends StatelessWidget {
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _salaryFocusNode = FocusNode();
  final FocusNode _dobFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _joinedDateFocusNode = FocusNode();
  final FocusNode _pictureUrlFocusNode = FocusNode();
  final FocusNode _houseNumberFocusNode = FocusNode();
  final FocusNode _streetFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _stateFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _firstNameFocusNode.unfocus();
        _lastNameFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(
            sectionName: 'Add Staff',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: StaffAddForm(
              firstNameFocusNode: _firstNameFocusNode,
              lastNameFocusNode: _lastNameFocusNode,
              salaryFocusNode: _salaryFocusNode,
              dobFocusNode: _dobFocusNode,
              joinedDateFocusNode: _joinedDateFocusNode,
              pictureUrlFocusNode: _pictureUrlFocusNode,
              phoneFocusNode: _phoneFocusNode,
              emailFocusNode: _emailFocusNode,
              houseNumberFocusNode: _houseNumberFocusNode,
              streetFocusNode: _streetFocusNode,
              cityFocusNode: _cityFocusNode,
              stateFocusNode: _stateFocusNode,
              countryFocusNode: _countryFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
