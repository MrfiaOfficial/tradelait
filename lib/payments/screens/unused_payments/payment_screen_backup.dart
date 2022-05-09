import 'package:flutter/material.dart';
import 'package:tradelait/payments/screens/unused_payments/payment_add_form.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';
import 'payment_add_form.dart';

class PaymentAddScreen extends StatelessWidget {
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _purposeFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _methodFocusNode = FocusNode();
  final FocusNode _balanceFocusNode = FocusNode();
  final FocusNode _paymentUidFocusNode = FocusNode();
  final FocusNode _payerBrokerNameFocusNode = FocusNode();
  final FocusNode _payerLastNameFocusNode = FocusNode();
  final FocusNode _payerUidFocusNode = FocusNode();

  /* final String payerUid;

  PaymentAddScreen({required this.payerUid}); */

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _amountFocusNode.unfocus();
        _purposeFocusNode.unfocus();
        _dateFocusNode.unfocus();
        _methodFocusNode.unfocus();
        _balanceFocusNode.unfocus();
        _payerUidFocusNode.unfocus();
        _payerBrokerNameFocusNode.unfocus();
        _payerLastNameFocusNode.unfocus();
        _paymentUidFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(
            sectionName: 'Add Payment',
          ),
        ),
        //drawer: ArgonDrawer(currentPage: "Add Payment"),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: PaymentAddForm(
              amountFocusNode: _amountFocusNode,
              purposeFocusNode: _purposeFocusNode,
              dateFocusNode: _dateFocusNode,
              methodFocusNode: _methodFocusNode,
              balanceFocusNode: _balanceFocusNode,
              paymentUidFocusNode: _paymentUidFocusNode,
              payerBrokerNameFocusNode: _payerBrokerNameFocusNode,
              payerLastNameFocusNode: _payerLastNameFocusNode,
              payerUidFocusNode: _payerUidFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
