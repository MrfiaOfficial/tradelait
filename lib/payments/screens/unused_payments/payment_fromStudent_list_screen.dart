import 'package:tradelait/payments/screens/unused_payments/payment_frombroker_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class PaymentListScreenFrombroker extends StatefulWidget {
  final String brokerUid;
  final String brokerName;
  final String lastName;
  const PaymentListScreenFrombroker({
    Key? key,
    required this.brokerUid,
    required this.brokerName,
    required this.lastName,
  }) : super(key: key);
  @override
  _PaymentListScreenFrombrokerstate createState() =>
      _PaymentListScreenFrombrokerstate();
}

class _PaymentListScreenFrombrokerstate
    extends State<PaymentListScreenFrombroker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: 'Payments List',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: PaymentListWidgetFrombroker(
            brokerUid: widget.brokerUid,
            brokerName: widget.brokerName,
            lastName: widget.lastName,
          ),
        ),
      ),
    );
  }
}
