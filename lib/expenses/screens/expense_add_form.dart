import 'package:tradelait/expenses/services/expense_service.dart';
import 'package:tradelait/widgets/custom_form_field.dart';
import 'package:tradelait/widgets/custom_number_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/services/validators/db_validator.dart';
import 'package:intl/intl.dart';

class ExpenseAddForm extends StatefulWidget {
  final FocusNode amountFocusNode;
  final FocusNode balanceFocusNode;
  final FocusNode payeeBrokerNameFocusNode;
  final FocusNode payeeLastNameFocusNode;

  const ExpenseAddForm({
    required this.amountFocusNode,
    required this.balanceFocusNode,
    required this.payeeBrokerNameFocusNode,
    required this.payeeLastNameFocusNode,
  });

  @override
  _ExpenseAddFormState createState() => _ExpenseAddFormState();
}

class _ExpenseAddFormState extends State<ExpenseAddForm> {
  final _addItemFormKey = GlobalKey<FormState>();
  var currentUser = FirebaseAuth.instance.currentUser;
  bool _isProcessing = false;

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

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _payeeBrokerNameController =
      TextEditingController();
  final TextEditingController _payeeLastNameController =
      TextEditingController();
  String _purpose = 'Fuel';
  String _method = 'Cash';

  @override
  void initState() {
    _dateController.text =
        new DateTime.now().toString().split(" ")[0].toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 24.0,
      ),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _addItemFormKey,
        child: ListView(
          children: [
            Column(
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
                  iconDisabledColor: Palette.firebaseYellow,
                  iconEnabledColor: Palette.firebaseYellow,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Palette.firebaseYellow,
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Palette.firebaseNavy,
                      size: 25,
                    ),
                    labelStyle:
                        TextStyle(color: Palette.firebaseYellow, fontSize: 16),
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
                  iconDisabledColor: Palette.firebaseYellow,
                  iconEnabledColor: Palette.firebaseYellow,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Palette.firebaseYellow,
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Palette.firebaseNavy,
                      size: 25,
                    ),
                    labelStyle:
                        TextStyle(color: Palette.firebaseYellow, fontSize: 16),
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
                    labelStyle:
                        TextStyle(color: Palette.firebaseYellow, fontSize: 16),
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
                        initialDate: DateTime.now(),
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
                      setState(() {
                        _dateController.text =
                            DateTime.now().toString().split(" ")[0].toString();
                      });
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
                CustomNumberFormField(
                  isLabelEnabled: false,
                  controller: _amountController,
                  focusNode: widget.amountFocusNode,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'Amount',
                  hint: 'Enter amount paid',
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
                CustomNumberFormField(
                  isLabelEnabled: false,
                  controller: _balanceController,
                  focusNode: widget.balanceFocusNode,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'Balance',
                  hint: 'Enter outstanding/balance here',
                ),
                SizedBox(height: 20.0),
                Text(
                  'Payee Broker Name',
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
                  controller: _payeeBrokerNameController,
                  focusNode: widget.payeeBrokerNameFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateNotRequired(
                    value: value,
                  ),
                  label: 'Payee Broker Name',
                  hint: 'Enter the receiver\'s broker name',
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
                        widget.balanceFocusNode.unfocus();
                        widget.payeeBrokerNameFocusNode.unfocus();
                        widget.payeeLastNameFocusNode.unfocus();

                        //
                        if (_addItemFormKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });
                          //

                          await ExpenseService(uid: currentUser!.uid)
                              .addExpense(
                            amount: _amountController.text.trim(),
                            purpose: _purpose,
                            method: _method,
                            date: _dateController.text,
                            balance: _balanceController.text.trim(),
                            payeeBrokerName:
                                _payeeBrokerNameController.text.trim(),
                            payeeLastName: _payeeLastNameController.text.trim(),
                            expenseUid: '',
                            createdTimeStamp: new DateTime.now().toString(),
                            updatedTimeStamp: new DateTime.now().toString(),
                            credit: false,
                          );
                          print('add expense button clicked');
                          //}

                          setState(() {
                            _isProcessing = false;
                          });

                          Navigator.of(context).pop();
                          /* Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaymentListScreen(),
                        ),
                      ); */
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'ADD EXPENSE',
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
