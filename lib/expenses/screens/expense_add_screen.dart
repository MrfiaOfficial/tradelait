import 'package:tradelait/expenses/screens/expense_add_form.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class ExpenseAddScreen extends StatelessWidget {
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _balanceFocusNode = FocusNode();
  final FocusNode _payeeFirstNameFocusNode = FocusNode();
  final FocusNode _payeeLastNameFocusNode = FocusNode();

  /*  ExpenseAddScreen({
    Key? key,
    this.payeeFirstName,
    this.payeeLastName,
  }) : super(key: key);
 */
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _amountFocusNode.unfocus();
        _balanceFocusNode.unfocus();
        _payeeFirstNameFocusNode.unfocus();
        _payeeLastNameFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(
            sectionName: 'Add Expense',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: ExpenseAddForm(
              amountFocusNode: _amountFocusNode,
              balanceFocusNode: _balanceFocusNode,
              payeeFirstNameFocusNode: _payeeFirstNameFocusNode,
              payeeLastNameFocusNode: _payeeLastNameFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
