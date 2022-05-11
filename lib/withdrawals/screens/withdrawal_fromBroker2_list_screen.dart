import 'package:tradelait/withdrawals/screens/withdrawal_frombroker_add_screen.dart';
import 'package:flutter/material.dart';

import 'package:tradelait/withdrawals/screens/withdrawal_fromBroker2_list_widget.dart';

import '../../res/custom_colors.dart';
import '../../widgets/app_bar_title.dart';

class WithdrawalListScreenFromBroker2 extends StatefulWidget {
  final String brokerUid;
  final String brokerName;
  const WithdrawalListScreenFromBroker2({
    Key? key,
    required this.brokerUid,
    required this.brokerName,
  }) : super(key: key);
  @override
  _WithdrawalListScreenFromBroker2State createState() =>
      _WithdrawalListScreenFromBroker2State();
}

class _WithdrawalListScreenFromBroker2State
    extends State<WithdrawalListScreenFromBroker2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: widget.brokerName + ' ' + 'Withdrawals',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'withdrawals',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WithdrawalAddScreenFromBroker(
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
      //drawer: ArgonDrawer(currentPage: "Withdrawals List"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: WithdrawalListWidgetFromBroker2(
            brokerUid: widget.brokerUid,
            brokerName: widget.brokerName,
          ),
        ),
      ),
    );
  }
}
