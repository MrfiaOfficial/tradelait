import 'package:tradelait/expenses/services/expense_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/widgets/custom_form_field.dart';
import 'package:intl/intl.dart';

class ExpenseEditForm extends StatefulWidget {
  final FocusNode amountFocusNode;
  final FocusNode purposeFocusNode;
  final FocusNode dateFocusNode;
  final FocusNode methodFocusNode;
  final FocusNode balanceFocusNode;
  final FocusNode payeeFirstNameFocusNode;
  final FocusNode payeeLastNameFocusNode;
  //
  final String currentAmount;
  final String currentPurpose;
  final String currentDate;
  final String currentMethod;
  final String currentBalance;
  final String currentPayeeFirstName;
  final String currentPayeeLastName;
  final String expenseUid;
  final String createdTimeStamp;
  final bool credit;

  const ExpenseEditForm({
    required this.amountFocusNode,
    required this.purposeFocusNode,
    required this.dateFocusNode,
    required this.methodFocusNode,
    required this.balanceFocusNode,
    required this.payeeFirstNameFocusNode,
    required this.payeeLastNameFocusNode,
    //
    required this.currentAmount,
    required this.currentPurpose,
    required this.currentDate,
    required this.currentMethod,
    required this.currentBalance,
    required this.currentPayeeFirstName,
    required this.currentPayeeLastName,
    required this.expenseUid,
    required this.createdTimeStamp,
    required this.credit,
  });

  @override
  _ExpenseEditFormState createState() => _ExpenseEditFormState();
}

class _ExpenseEditFormState extends State<ExpenseEditForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  //
  // Purposes dropdown item list
  final List<String> purposes = [
    'Fuel',
    'Electricity',
    'Stationeries',
    'Hospitality',
    'Transport',
    'Community Services',
    'Association Levies',
    'Government Levies',
    'Taxes',
    'Repairs',
    'Artisan',
    'Other Levies',
    'Events',
    'Cleaning',
    'Others',
  ];

  // Method dropdown item list
  final List<String> methods = [
    'Cash',
    'Cheque',
    'Bank Transfer',
    'Bank Deposit',
    'Debit/Credit Card',
    'Online Gateways'
  ];

  bool _isProcessing = false;

  late TextEditingController _amountController;
  late TextEditingController _dateController;
  late TextEditingController _balanceController;
  late TextEditingController _payeeFirstNameController;
  late TextEditingController _payeeLastNameController;
  String _purpose = 'Fuel';
  String _method = 'Cash';

  @override
  void initState() {
    _amountController = TextEditingController(
      text: widget.currentAmount,
    );

    _purpose = widget.currentPurpose;
    _method = widget.currentMethod;

    _dateController = TextEditingController(
      text: widget.currentDate,
    );

    _balanceController = TextEditingController(
      text: widget.currentBalance,
    );

    _payeeFirstNameController =
        TextEditingController(text: widget.currentPayeeFirstName);

    _payeeLastNameController = TextEditingController(
      text: widget.currentPayeeLastName,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _editItemFormKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    'Purpose',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Palette.firebaseYellow,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Palette.firebaseYellow,
                        size: 25,
                      ),
                      labelStyle: TextStyle(
                          color: Palette.firebaseYellow, fontSize: 16),
                      hintStyle: TextStyle(
                        color: Palette.firebaseGrey.withOpacity(0.5),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Palette.firebaseAmber,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Palette.firebaseGrey.withOpacity(0.5),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 2,
                        ),
                      ),
                    ),
                    style: TextStyle(color: Palette.firebaseNavy, fontSize: 15),
                    value: _purpose,
                    items: purposes.map((purpose) {
                      return DropdownMenuItem(
                        value: purpose,
                        child: Text('$purpose'),
                      );
                    }).toList(),
                    onChanged: (String? val) => setState(() => _purpose = val!),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Method',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Palette.firebaseYellow,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Palette.firebaseYellow,
                        size: 25,
                      ),
                      labelStyle: TextStyle(
                          color: Palette.firebaseYellow, fontSize: 16),
                      hintStyle: TextStyle(
                        color: Palette.firebaseGrey.withOpacity(0.5),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Palette.firebaseAmber,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Palette.firebaseGrey.withOpacity(0.5),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 2,
                        ),
                      ),
                    ),
                    style: TextStyle(color: Palette.firebaseNavy, fontSize: 15),
                    value: _method,
                    items: methods.map((method) {
                      return DropdownMenuItem(
                        value: method,
                        child: Text('$method'),
                      );
                    }).toList(),
                    onChanged: (String? val) => setState(() => _method = val!),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Date',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Palette.firebaseYellow,
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: Palette.firebaseNavy,
                        size: 25,
                      ),
                      hintText: 'Select Date',
                      labelStyle: TextStyle(
                          color: Palette.firebaseYellow, fontSize: 16),
                      hintStyle: TextStyle(
                        color: Palette.firebaseNavy,
                      ),
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Palette.firebaseAmber,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Palette.firebaseGrey.withOpacity(0.5),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 2,
                        ),
                      ),
                    ),
                    style: TextStyle(color: Palette.firebaseNavy, fontSize: 15),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.parse(widget.currentDate),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(formattedDate);

                        setState(() {
                          _dateController.text = formattedDate;
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Amount',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  CustomFormField(
                    isLabelEnabled: false,
                    controller: _amountController,
                    focusNode: widget.amountFocusNode,
                    keyboardType: TextInputType.phone,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Amount',
                    hint: 'Edit the amount here',
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Balance',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  CustomFormField(
                    //maxLines: 10,
                    isLabelEnabled: false,
                    controller: _balanceController,
                    focusNode: widget.balanceFocusNode,
                    keyboardType: TextInputType.phone,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Balance',
                    hint: 'Edit the balance/outstanding amount',
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Payee First Name',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  CustomFormField(
                    isLabelEnabled: false,
                    controller: _payeeFirstNameController,
                    focusNode: widget.payeeFirstNameFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Payee First Name',
                    hint: 'Enter the receiver\'s first name',
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Payee Last Name',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  CustomFormField(
                    isLabelEnabled: false,
                    controller: _payeeLastNameController,
                    focusNode: widget.payeeLastNameFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Payee Last Name',
                    hint: 'Enter the receiver\'s last name',
                  ),
                  SizedBox(height: 20.0),
                ],
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
                        widget.payeeFirstNameFocusNode.unfocus();
                        widget.payeeLastNameFocusNode.unfocus();

                        if (_editItemFormKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });

                          // to get the current user uid and add the student
                          // under his account
                          var currentUser = FirebaseAuth.instance.currentUser;

                          if (currentUser != null) {
                            await ExpenseService(uid: currentUser.uid)
                                .updateExpense(
                              expenseUid: widget.expenseUid,
                              amount: _amountController.text.trim(),
                              purpose: _purpose,
                              method: _method,
                              date: _dateController.text,
                              balance: _balanceController.text.trim(),
                              payeeFirstName:
                                  _payeeFirstNameController.text.trim(),
                              payeeLastName:
                                  _payeeLastNameController.text.trim(),
                              createdTimeStamp: widget.createdTimeStamp,
                              updatedTimeStamp: new DateTime.now().toString(),
                              credit: widget.credit,
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
                          'UPDATE EXPENSE',
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
      ),
    );
  }
}
