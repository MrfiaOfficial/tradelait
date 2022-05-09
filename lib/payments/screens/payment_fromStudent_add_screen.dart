import 'package:tradelait/payments/screens/payment_frombroker_add_form.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class PaymentAddScreenFrombroker extends StatelessWidget {
  final String payerUid;
  final String payerBrokerName;
  final String payerLastName;
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _balanceFocusNode = FocusNode();

  PaymentAddScreenFrombroker(
      {Key? key,
      required this.payerUid,
      required this.payerBrokerName,
      required this.payerLastName})
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
            sectionName: 'Add Payment',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: PaymentAddFormFrombroker(
              payerUid: payerUid,
              payerBrokerName: payerBrokerName,
              payerLastName: payerLastName,
              amountFocusNode: _amountFocusNode,
              balanceFocusNode: _balanceFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
