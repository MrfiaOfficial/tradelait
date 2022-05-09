import 'package:tradelait/deposits/screens/deposit_fromBroker_add_form.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class DepositAddScreenFromBroker extends StatelessWidget {
  final String brokerUid;
  final String brokerName;
  final FocusNode _amountFocusNode = FocusNode();

  DepositAddScreenFromBroker({
    Key? key,
    required this.brokerUid,
    required this.brokerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _amountFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(
            sectionName: 'Add Deposit',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: DepositAddFormFromBroker(
              brokerUid: brokerUid,
              brokerName: brokerName,
              amountFocusNode: _amountFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
