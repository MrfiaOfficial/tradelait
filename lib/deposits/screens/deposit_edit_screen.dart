import 'package:tradelait/deposits/screens/deposit_edit_form.dart';
import 'package:tradelait/deposits/services/deposit_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../res/custom_colors.dart';
import '../../widgets/app_bar_title.dart';

class DepositEditScreen extends StatefulWidget {
  final String currentAmount;
  final String currentDate;
  final String currentMethod;
  final String currentBrokerName;
  final String currentBrokerUid;
  final String depositUid;
  final String createdDate;
  final String createdTime;
  final String timeStamp;
  final bool credit;

  DepositEditScreen({
    required this.currentAmount,
    required this.currentDate,
    required this.currentMethod,
    required this.currentBrokerName,
    required this.currentBrokerUid,
    required this.depositUid,
    required this.createdDate,
    required this.createdTime,
    required this.timeStamp,
    required this.credit,
  });

  @override
  _DepositEditScreenState createState() => _DepositEditScreenState();
}

class _DepositEditScreenState extends State<DepositEditScreen> {
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _methodFocusNode = FocusNode();
  final FocusNode _brokerNameFocusNode = FocusNode();
  final FocusNode _brokerUidFocusNode = FocusNode();

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
        _brokerNameFocusNode.unfocus();
        _brokerUidFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(sectionName: 'Edit Deposit'),
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

                      await DepositService(uid: currentUser!.uid).deleteDeposit(
                        depositUid: widget.depositUid,
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
            child: DepositEditForm(
              amountFocusNode: _amountFocusNode,
              dateFocusNode: _dateFocusNode,
              methodFocusNode: _methodFocusNode,
              brokerNameFocusNode: _brokerNameFocusNode,
              brokerUidFocusNode: _brokerUidFocusNode,
              //
              depositUid: widget.depositUid,
              currentAmount: widget.currentAmount,
              currentBrokerName: widget.currentBrokerName,
              currentDate: widget.currentDate,
              currentMethod: widget.currentMethod,
              currentBrokerUid: widget.currentBrokerUid,
              createdDate: widget.createdDate,
              createdTime: widget.createdTime,
              timeStamp: widget.timeStamp,
              credit: widget.credit,
            ),
          ),
        ),
      ),
    );
  }
}
