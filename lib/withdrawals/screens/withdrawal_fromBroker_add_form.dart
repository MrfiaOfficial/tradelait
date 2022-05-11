import 'package:tradelait/withdrawals/services/withdrawal_service.dart';
import 'package:tradelait/widgets/custom_number_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/services/validators/db_validator.dart';
import 'package:intl/intl.dart';

class WithdrawalAddFormFromBroker extends StatefulWidget {
  final String? brokerUid;
  final String? brokerName;
  final FocusNode amountFocusNode;

  const WithdrawalAddFormFromBroker({
    this.brokerUid,
    this.brokerName,
    required this.amountFocusNode,
  });

  @override
  _WithdrawalAddFormFromBrokerState createState() =>
      _WithdrawalAddFormFromBrokerState();
}

class _WithdrawalAddFormFromBrokerState
    extends State<WithdrawalAddFormFromBroker> {
  final _addItemFormKey = GlobalKey<FormState>();
  var currentUser = FirebaseAuth.instance.currentUser;

  // Method dropdown item list
  final List<String> methods = [
    'Cash',
    'Cheque',
    'Bank Transfer',
    'Bank Withdrawal',
    'Debit/Credit Card',
    'Online Gateways'
  ];

  bool _isProcessing = false;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String _method = 'Bank Transfer';
  String _customWithdrawalUid = '';

  @override
  void initState() {
    _dateController.text =
        new DateTime.now().toString().split(" ")[0].toString();
    getCustomWithdrawalUid();
    super.initState();
  }

  getCustomWithdrawalUid() {
    var brokerName = widget.brokerName;

    var year = DateTime.now().year.toString();
    var month = DateTime.now().month.toString();
    var day = DateTime.now().day.toString();

    var hour = DateTime.now().hour.toString();
    var mlsecond = DateTime.now().millisecond.toString();
    var misecond = DateTime.now().microsecond.toString();

    var dateStamp = year + month + day;
    var timeStamp = hour + mlsecond + misecond;
    var dateTime = dateStamp + timeStamp;
    var customWithdrawalUid =
        brokerName.toString().substring(0, 6) + dateTime.substring(0, 13);

    setState(() {
      _customWithdrawalUid = customWithdrawalUid;
    });
    return print(customWithdrawalUid);
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

                        //
                        if (_addItemFormKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });
                          //

                          await WithdrawalService(uid: currentUser!.uid)
                              .addWithdrawal(
                            amount: _amountController.text.trim(),
                            method: _method,
                            date: _dateController.text,
                            brokerName: widget.brokerName,
                            brokerUid: widget.brokerUid,
                            withdrawalUid: _customWithdrawalUid,
                            createdDate:
                                new DateTime.now().toString().split(" ")[0],
                            updatedDate:
                                new DateTime.now().toString().split(" ")[0],
                            createdTime:
                                new DateTime.now().toString().split(" ")[1],
                            updatedTime:
                                new DateTime.now().toString().split(" ")[1],
                            timeStamp: new DateTime.now().toString(),
                            credit: true,
                          );
                          print('add withdrawals button clicked');
                          //}

                          setState(() {
                            _isProcessing = false;
                          });

                          Navigator.of(context).pop();
                          /* Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WithdrawalListScreen(),
                        ),
                      ); */
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'ADD WITHDRAWAL',
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
