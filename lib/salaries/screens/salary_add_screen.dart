import 'package:tradelait/salaries/screens/salary_add_form.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class SalaryAddScreen extends StatelessWidget {
  final String staffUid;
  final String staffFirstName;
  final String staffLastName;
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _balanceFocusNode = FocusNode();

  SalaryAddScreen(
      {Key? key,
      required this.staffUid,
      required this.staffFirstName,
      required this.staffLastName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _amountFocusNode.unfocus();
        _balanceFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(
            sectionName: 'Add Salary',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: SalaryAddForm(
              staffUid: staffUid,
              staffFirstName: staffFirstName,
              staffLastName: staffLastName,
              amountFocusNode: _amountFocusNode,
              balanceFocusNode: _balanceFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
