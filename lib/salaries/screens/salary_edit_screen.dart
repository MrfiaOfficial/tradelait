import 'package:tradelait/salaries/screens/salary_edit_form.dart';
import 'package:tradelait/salaries/services/salary_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class SalaryEditScreen extends StatefulWidget {
  final String currentAmount;
  final String currentPurpose;
  final String currentDate;
  final String currentMethod;
  final String currentBalance;
  final String staffFirstName;
  final String staffLastName;
  final String staffUid;
  final String salaryUid;
  final String createdTimeStamp;
  final bool credit;

  SalaryEditScreen({
    required this.currentAmount,
    required this.currentPurpose,
    required this.currentDate,
    required this.currentMethod,
    required this.currentBalance,
    required this.staffFirstName,
    required this.staffLastName,
    required this.staffUid,
    required this.salaryUid,
    required this.createdTimeStamp,
    required this.credit,
  });

  @override
  _SalaryEditScreenState createState() => _SalaryEditScreenState();
}

class _SalaryEditScreenState extends State<SalaryEditScreen> {
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _balanceFocusNode = FocusNode();

  bool _isDeleting = false;
  var currentUser = FirebaseAuth.instance.currentUser;

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
          title: AppBarTitle(sectionName: 'Edit Salary'),
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

                      await SalaryService(uid: currentUser!.uid).deleteSalary(
                        salaryUid: widget.salaryUid,
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
            child: SalaryEditForm(
              amountFocusNode: _amountFocusNode,
              balanceFocusNode: _balanceFocusNode,
              //
              salaryUid: widget.salaryUid,
              currentAmount: widget.currentAmount,
              currentPurpose: widget.currentPurpose,
              currentDate: widget.currentDate,
              currentMethod: widget.currentMethod,
              currentBalance: widget.currentBalance,
              staffFirstName: widget.staffFirstName,
              staffLastName: widget.staffLastName,
              staffUid: widget.staffUid,
              createdTimeStamp: widget.createdTimeStamp,
              credit: widget.credit,
            ),
          ),
        ),
      ),
    );
  }
}
