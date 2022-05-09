import 'package:tradelait/deposits/screens/deposit_frombroker_add_screen.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/deposits/screens/deposit_fromBroker2_list_widget.dart';

import '../../res/custom_colors.dart';
import '../../widgets/app_bar_title.dart';

class DepositListScreenFromBroker2 extends StatefulWidget {
  final String brokerUid;
  final String brokerName;
  const DepositListScreenFromBroker2({
    Key? key,
    required this.brokerUid,
    required this.brokerName,
  }) : super(key: key);
  @override
  _DepositListScreenFromBroker2State createState() =>
      _DepositListScreenFromBroker2State();
}

class _DepositListScreenFromBroker2State
    extends State<DepositListScreenFromBroker2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: widget.brokerName + ' ' + 'Deposits',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'deposit',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DepositAddScreenFromBroker(
                brokerUid: widget.brokerUid,
                brokerName: widget.brokerName,
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
      //drawer: ArgonDrawer(currentPage: "Deposits List"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: DepositListWidgetFromBroker2(
            brokerUid: widget.brokerUid,
            brokerName: widget.brokerName,
          ),
        ),
      ),
    );
  }
}
