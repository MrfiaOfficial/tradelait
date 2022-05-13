import 'package:tradelait/signals/services/signal_service.dart';
import 'package:tradelait/widgets/custom_form_field.dart';
import 'package:tradelait/widgets/custom_number_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/services/validators/db_validator.dart';
import 'package:intl/intl.dart';

class SignalAddForm extends StatefulWidget {
  final FocusNode entryPriceFocusNode;
  final FocusNode currencyPairFocusNode;
  final FocusNode takeProfit1FocusNode;
  final FocusNode takeProfit2FocusNode;
  final FocusNode takeProfit3FocusNode;
  final FocusNode stopLossFocusNode;

  const SignalAddForm({
    required this.entryPriceFocusNode,
    required this.currencyPairFocusNode,
    required this.takeProfit1FocusNode,
    required this.takeProfit2FocusNode,
    required this.takeProfit3FocusNode,
    required this.stopLossFocusNode,
  });

  @override
  _SignalAddFormState createState() => _SignalAddFormState();
}

class _SignalAddFormState extends State<SignalAddForm> {
  final _addItemFormKey = GlobalKey<FormState>();
  var currentUser = FirebaseAuth.instance.currentUser;
  bool _isProcessing = false;

  //Signal Types dropdown item list
  final List<String> signalTypes = [
    'Forex',
    'Crypto',
    'Stocks',
    'Others',
  ];

  // Order Types dropdown item list
  final List<String> orderTypes = [
    'BUY',
    'SELL',
    'BUY STOP',
    'SELL STOP',
    'BUY LIMIT',
    'SELL LIMIT',
    'STOP LIMIT',
    'STOP MARKET',
  ];

  // TimeFrame dropdown item list
  final List<String> timeFrames = [
    'M1',
    'M5',
    'M15',
    'M30',
    'H1',
    'H4',
    'D1',
    'W1',
    'MN',
  ];

  final TextEditingController _entryPriceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _stopLossController = TextEditingController();
  final TextEditingController _currencyPairController = TextEditingController();
  final TextEditingController _takeProfit1Controller = TextEditingController();
  final TextEditingController _takeProfit2Controller = TextEditingController();
  final TextEditingController _takeProfit3Controller = TextEditingController();
  String _signalType = 'Forex';
  String _orderType = 'BUY';
  String _timeFrame = 'H1';

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
                  'Signal Type',
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
                  value: _signalType,
                  items: signalTypes.map((signalType) {
                    return DropdownMenuItem(
                      value: signalType,
                      child: Text('$signalType'),
                    );
                  }).toList(),
                  onChanged: (String? val) =>
                      setState(() => _signalType = val!),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Currency Pair',
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
                  controller: _currencyPairController,
                  focusNode: widget.currencyPairFocusNode,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'Currency Pair',
                  hint: 'Enter the currency pair here',
                ),
                SizedBox(height: 20.0),
                Text(
                  'Order Type',
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
                  value: _orderType,
                  items: orderTypes.map((orderType) {
                    return DropdownMenuItem(
                      value: orderType,
                      child: Text('$orderType'),
                    );
                  }).toList(),
                  onChanged: (String? val) => setState(() => _orderType = val!),
                ),
                SizedBox(height: 20.0),
                SizedBox(height: 20.0),
                Text(
                  'Entry Price',
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
                  controller: _entryPriceController,
                  focusNode: widget.entryPriceFocusNode,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'Entry Price',
                  hint: 'Enter the entry price here',
                ),
                SizedBox(height: 20.0),
                Text(
                  'Time Frame',
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
                  value: _timeFrame,
                  items: timeFrames.map((timeFrame) {
                    return DropdownMenuItem(
                      value: timeFrame,
                      child: Text('$timeFrame'),
                    );
                  }).toList(),
                  onChanged: (String? val) => setState(() => _timeFrame = val!),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Take Profit 1 (TP1)',
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
                  controller: _takeProfit1Controller,
                  focusNode: widget.takeProfit1FocusNode,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'TP1',
                  hint: 'Enter TP1 here',
                ),
                SizedBox(height: 20.0),
                Text(
                  'Take Profit 2 (TP2)',
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
                  controller: _takeProfit2Controller,
                  focusNode: widget.takeProfit2FocusNode,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'TP2',
                  hint: 'Enter TP2 here',
                ),
                SizedBox(height: 20.0),
                Text(
                  'Take Profit 3 (TP3)',
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
                  controller: _takeProfit3Controller,
                  focusNode: widget.takeProfit3FocusNode,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'TP3',
                  hint: 'Enter TP3 here',
                ),
                SizedBox(height: 20.0),
                Text(
                  'Stop Loss (SL)',
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
                  controller: _stopLossController,
                  focusNode: widget.stopLossFocusNode,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'SL',
                  hint: 'Enter the stop loss here',
                ),
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
                        widget.entryPriceFocusNode.unfocus();
                        widget.stopLossFocusNode.unfocus();
                        widget.currencyPairFocusNode.unfocus();
                        widget.takeProfit1FocusNode.unfocus();
                        widget.takeProfit2FocusNode.unfocus();
                        widget.takeProfit3FocusNode.unfocus();

                        //
                        if (_addItemFormKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });
                          //

                          await SignalService().addSignal(
                            signalUid: '',
                            signalType: _signalType,
                            currencyPair: _currencyPairController.text,
                            orderType: _orderType,
                            entryPrice: _entryPriceController.text.trim(),
                            timeFrame: _timeFrame,
                            takeProfit1: _takeProfit1Controller.text,
                            takeProfit2: _takeProfit2Controller.text,
                            takeProfit3: _takeProfit3Controller.text,
                            stopLoss: _stopLossController.text,
                            date: _dateController.text,
                            createdTimeStamp: new DateTime.now().toString(),
                            updatedTimeStamp: new DateTime.now().toString(),
                          );
                          print('add signal button clicked');
                          //}

                          setState(() {
                            _isProcessing = false;
                          });

                          Navigator.of(context).pop();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'ADD SIGNAL',
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
