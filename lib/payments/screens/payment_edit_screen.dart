import 'package:tradelait/payments/screens/payment_edit_form.dart';
import 'package:tradelait/payments/services/payment_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../res/custom_colors.dart';
import '../../widgets/app_bar_title.dart';

class PaymentEditScreen extends StatefulWidget {
  final String currentAmount;
  final String currentPurpose;
  final String currentDate;
  final String currentMethod;
  final String currentBalance;
  final String currentPayerFirstName;
  final String currentPayerLastName;
  final String currentPayerUid;
  final String paymentUid;
  final String createdDate;
  final String createdTime;
  final String timeStamp;
  final bool credit;

  PaymentEditScreen({
    required this.currentAmount,
    required this.currentPurpose,
    required this.currentDate,
    required this.currentMethod,
    required this.currentBalance,
    required this.currentPayerFirstName,
    required this.currentPayerLastName,
    required this.currentPayerUid,
    required this.paymentUid,
    required this.createdDate,
    required this.createdTime,
    required this.timeStamp,
    required this.credit,
  });

  @override
  _PaymentEditScreenState createState() => _PaymentEditScreenState();
}

class _PaymentEditScreenState extends State<PaymentEditScreen> {
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _purposeFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _methodFocusNode = FocusNode();
  final FocusNode _balanceFocusNode = FocusNode();
  final FocusNode _payerFirstNameFocusNode = FocusNode();
  final FocusNode _payerLastNameFocusNode = FocusNode();
  final FocusNode _payerUidFocusNode = FocusNode();

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
        _payerFirstNameFocusNode.unfocus();
        _payerLastNameFocusNode.unfocus();
        _payerUidFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(sectionName: 'Edit Payment'),
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

                      await PaymentService(uid: currentUser!.uid).deletePayment(
                        paymentUid: widget.paymentUid,
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
            child: PaymentEditForm(
              amountFocusNode: _amountFocusNode,
              purposeFocusNode: _purposeFocusNode,
              dateFocusNode: _dateFocusNode,
              methodFocusNode: _methodFocusNode,
              balanceFocusNode: _balanceFocusNode,
              payerFirstNameFocusNode: _payerFirstNameFocusNode,
              payerLastNameFocusNode: _payerLastNameFocusNode,
              payerUidFocusNode: _payerUidFocusNode,
              //
              paymentUid: widget.paymentUid,
              currentAmount: widget.currentAmount,
              currentPurpose: widget.currentPurpose,
              currentDate: widget.currentDate,
              currentMethod: widget.currentMethod,
              currentBalance: widget.currentBalance,
              currentPayerFirstName: widget.currentPayerFirstName,
              currentPayerLastName: widget.currentPayerLastName,
              currentPayerUid: widget.currentPayerUid,
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
