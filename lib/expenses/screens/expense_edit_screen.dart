import 'package:tradelait/expenses/screens/expense_edit_form.dart';
import 'package:tradelait/expenses/services/expense_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class ExpenseEditScreen extends StatefulWidget {
  final String currentAmount;
  final String currentPurpose;
  final String currentDate;
  final String currentMethod;
  final String currentBalance;
  final String? currentPayeeBrokerName;
  final String? currentPayeeLastName;
  final String expenseUid;
  final String createdTimeStamp;
  final bool credit;

  ExpenseEditScreen({
    required this.currentAmount,
    required this.currentPurpose,
    required this.currentDate,
    required this.currentMethod,
    required this.currentBalance,
    required this.currentPayeeBrokerName,
    required this.currentPayeeLastName,
    required this.expenseUid,
    required this.createdTimeStamp,
    required this.credit,
  });

  @override
  _ExpenseEditScreenState createState() => _ExpenseEditScreenState();
}

class _ExpenseEditScreenState extends State<ExpenseEditScreen> {
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _purposeFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _methodFocusNode = FocusNode();
  final FocusNode _balanceFocusNode = FocusNode();
  final FocusNode _payeeBrokerNameFocusNode = FocusNode();
  final FocusNode _payeeLastNameFocusNode = FocusNode();

  bool _isDeleting = false;
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _amountFocusNode.unfocus();
        _dateFocusNode.unfocus();
        _dateFocusNode.unfocus();
        _methodFocusNode.unfocus();
        _balanceFocusNode.unfocus();
        _payeeBrokerNameFocusNode.unfocus();
        _payeeLastNameFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(sectionName: 'Edit Expense'),
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

                      await ExpenseService(uid: currentUser!.uid).deleteExpense(
                        expenseUid: widget.expenseUid,
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
            child: ExpenseEditForm(
              amountFocusNode: _amountFocusNode,
              purposeFocusNode: _purposeFocusNode,
              dateFocusNode: _dateFocusNode,
              methodFocusNode: _methodFocusNode,
              balanceFocusNode: _balanceFocusNode,
              payeeBrokerNameFocusNode: _payeeBrokerNameFocusNode,
              payeeLastNameFocusNode: _payeeLastNameFocusNode,
              //
              expenseUid: widget.expenseUid,
              currentAmount: widget.currentAmount,
              currentPurpose: widget.currentPurpose,
              currentDate: widget.currentDate,
              currentMethod: widget.currentMethod,
              currentBalance: widget.currentBalance,
              currentPayeeBrokerName: widget.currentPayeeBrokerName ?? '',
              currentPayeeLastName: widget.currentPayeeLastName ?? '',
              createdTimeStamp: widget.createdTimeStamp,
              credit: widget.credit,
            ),
          ),
        ),
      ),
    );
  }
}
