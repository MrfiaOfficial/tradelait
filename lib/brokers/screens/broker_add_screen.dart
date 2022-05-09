import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'package:tradelait/brokers/screens/broker_add_form.dart';

class brokerAddScreen extends StatelessWidget {
  final FocusNode _brokerNameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _joinedDateFocusNode = FocusNode();
  final FocusNode _logoUrlFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _brokerNameFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(
            sectionName: 'Add broker',
          ),
        ),
        //drawer: ArgonDrawer(currentPage: "DbADdScreen"),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: brokerAddForm(
              brokerNameFocusNode: _brokerNameFocusNode,
              joinedDateFocusNode: _joinedDateFocusNode,
              logoUrlFocusNode: _logoUrlFocusNode,
              phoneFocusNode: _phoneFocusNode,
              emailFocusNode: _emailFocusNode,
              countryFocusNode: _countryFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
