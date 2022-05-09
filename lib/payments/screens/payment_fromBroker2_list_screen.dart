import 'package:tradelait/payments/screens/payment_frombroker_add_screen.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/payments/screens/payment_fromBroker2_list_widget.dart';

import '../../res/custom_colors.dart';
import '../../widgets/app_bar_title.dart';

class PaymentListScreenFromBroker2 extends StatefulWidget {
  final String brokerUid;
  final String brokerName;
  final String lastName;
  const PaymentListScreenFromBroker2({
    Key? key,
    required this.brokerUid,
    required this.brokerName,
    required this.lastName,
  }) : super(key: key);
  @override
  _PaymentListScreenFromBroker2State createState() =>
      _PaymentListScreenFromBroker2State();
}

class _PaymentListScreenFromBroker2State
    extends State<PaymentListScreenFromBroker2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName:
              widget.brokerName + ' ' + widget.lastName + ' ' + 'Payments',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'payment',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentAddScreenFromBroker(
                payerUid: widget.brokerUid,
                payerBrokerName: widget.brokerName,
                payerLastName: widget.lastName,
              ),
            ),
          );
        },
        backgroundColor: Palette.firebaseWhite,
        child: Icon(
          Icons.add,
          color: Palette.firebaseNavy,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //drawer: ArgonDrawer(currentPage: "Payments List"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: PaymentListWidgetFromBroker2(
            brokerUid: widget.brokerUid,
            brokerName: widget.brokerName,
            lastName: widget.lastName,
          ),
        ),
      ),
    );
  }
}
