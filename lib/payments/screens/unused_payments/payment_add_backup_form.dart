import 'package:tradelait/payments/services/payment_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../res/custom_colors.dart';
import 'package:tradelait/services/validators/db_validator.dart';

import '../../../widgets/custom_form_field.dart';

class PaymentAddForm extends StatefulWidget {
  final FocusNode amountFocusNode;
  final FocusNode purposeFocusNode;
  final FocusNode dateFocusNode;
  final FocusNode methodFocusNode;
  final FocusNode balanceFocusNode;
  final FocusNode payerFirstNameFocusNode;
  final FocusNode payerLastNameFocusNode;
  final FocusNode payerUidFocusNode;
  final FocusNode paymentUidFocusNode;
  //final String? uid;

  const PaymentAddForm({
    required this.amountFocusNode,
    required this.purposeFocusNode,
    required this.dateFocusNode,
    required this.methodFocusNode,
    required this.balanceFocusNode,
    required this.payerFirstNameFocusNode,
    required this.payerLastNameFocusNode,
    required this.payerUidFocusNode,
    required this.paymentUidFocusNode,
  });

  //get studentUid => null;

  @override
  _PaymentAddFormState createState() => _PaymentAddFormState();
}

class _PaymentAddFormState extends State<PaymentAddForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  // just added for dropdownitem
  /* final List<String> purpose = [
    'school fees',
    'stationery',
    'levies',
    'events',
    'others'
  ]; */

  bool _isProcessing = false;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _methodController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _payerFirstNameController =
      TextEditingController();
  final TextEditingController _payerLastNameController =
      TextEditingController();
  final TextEditingController _payerUidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _addItemFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.0),
                  Text(
                    'Payer\'s First Name',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    isLabelEnabled: true,
                    controller: _payerFirstNameController,
                    focusNode: widget.payerFirstNameFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Payer\'s First Name',
                    hint: 'Enter payer\'s first name here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Payer\'s Last tName',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    isLabelEnabled: false,
                    controller: _payerLastNameController,
                    focusNode: widget.payerLastNameFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Payer\'s Last name',
                    hint: 'Enter payer\'s last name here',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Payer\'s ID',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    isLabelEnabled: false,
                    controller: _payerUidController,
                    focusNode: widget.payerUidFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Payer\'s ID',
                    hint: 'Payer\'s ID',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Amount',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    isLabelEnabled: false,
                    controller: _amountController,
                    focusNode: widget.amountFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Amount',
                    hint: 'Enter amount paid',
                  ),
                  SizedBox(height: 24.0),
                  /*Text(
                  'Purpose',
                  style: TextStyle(
                    color: Palette.firebaseGrey,
                    fontSize: 22.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0), */
                  /* DropdownButtonFormField(
                  value: 'schhol fees',
                  //decoration: textInputDecoration(),
                  items: purpose.map((sugar) {
                    return DropdownMenuItem(
                      value: purpose,
                      child: Text('$purpose'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => val),
                ),
                SizedBox(height: 8.0), */
                  Text(
                    'Purpose',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  CustomFormField(
                    isLabelEnabled: false,
                    controller: _purposeController,
                    focusNode: widget.purposeFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Purpose',
                    hint: 'Enter purpose of payment',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Date',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    isLabelEnabled: false,
                    controller: _dateController,
                    focusNode: widget.dateFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Date',
                    hint: 'Enter date of payment',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Method',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    isLabelEnabled: false,
                    controller: _methodController,
                    focusNode: widget.methodFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Method',
                    hint: 'Cash, Card, Bank Transfer, Cheque',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Balance',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    isLabelEnabled: false,
                    controller: _balanceController,
                    focusNode: widget.balanceFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Balance',
                    hint: 'Enter outstanding/balance here',
                  ),
                ],
              ),
            ),
          ),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Palette.firebaseOrange,
                    ),
                  ),
                )
              : Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Palette.firebaseWhite,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      widget.amountFocusNode.unfocus();
                      widget.purposeFocusNode.unfocus();
                      widget.dateFocusNode.unfocus();
                      widget.methodFocusNode.unfocus();
                      widget.balanceFocusNode.unfocus();
                      widget.payerFirstNameFocusNode.unfocus();
                      widget.payerLastNameFocusNode.unfocus();

                      if (_addItemFormKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        // to get the current user uid and add the student
                        // under his account
                        var currentUser = FirebaseAuth.instance.currentUser;

                        if (currentUser != null) {
                          //print(currentUser.uid);
                          var paymentUid;
                          var studentUid;
                          //var payerUid;
                          var firstName;
                          var lastName;
                          await PaymentService(uid: currentUser.uid).addPayment(
                            amount: _amountController.text,
                            purpose: _purposeController.text,
                            date: _dateController.text,
                            method: _methodController.text,
                            balance: _balanceController.text,
                            payerFirstName:
                                firstName ?? _payerFirstNameController.text,
                            payerLastName:
                                lastName ?? _payerLastNameController.text,
                            payerUid: studentUid ?? _payerUidController.text,
                            paymentUid: paymentUid,
                          );
                        }

                        setState(() {
                          _isProcessing = false;
                        });

                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        'ADD PAYMENT',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Palette.firebaseNavy,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    ));
  }
}
