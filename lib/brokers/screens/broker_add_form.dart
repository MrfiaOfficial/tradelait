import 'package:tradelait/brokers/services/broker_service.dart';
import 'package:tradelait/widgets/custom_number_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/services/validators/db_validator.dart';
import 'package:tradelait/widgets/custom_form_field.dart';
import 'package:intl/intl.dart';

class brokerAddForm extends StatefulWidget {
  final FocusNode brokerNameFocusNode;
  final FocusNode phoneFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode joinedDateFocusNode;
  final FocusNode logoUrlFocusNode;
  final FocusNode countryFocusNode;
  //final String? uid;

  const brokerAddForm({
    required this.brokerNameFocusNode,
    required this.phoneFocusNode,
    required this.emailFocusNode,
    required this.joinedDateFocusNode,
    required this.logoUrlFocusNode,
    required this.countryFocusNode,
  });

  @override
  _brokerAddFormState createState() => _brokerAddFormState();
}

class _brokerAddFormState extends State<brokerAddForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  final TextEditingController _brokerNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _joinedDateController = TextEditingController();
  final TextEditingController _logoUrlController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  //
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool _isProcessing = false;
  String _customBrokerUid = '';
  String _brokerType = 'Forex';

  //
  @override
  void initState() {
    _joinedDateController.text =
        new DateTime.now().toString().split(" ")[0].toString();
    super.initState();
  }

  getCustomBrokerUid() {
    var brokerName = _brokerNameController.text;

    var year = DateTime.now().year.toString();
    var month = DateTime.now().month.toString();
    var day = DateTime.now().day.toString();

    var hour = DateTime.now().hour.toString();
    var mlsecond = DateTime.now().millisecond.toString();
    var misecond = DateTime.now().microsecond.toString();

    var dateStamp = year + month + day;
    var timeStamp = hour + mlsecond + misecond;
    var dateTime = dateStamp + timeStamp;
    var customBrokerUid =
        brokerName.substring(0, 6) + dateTime.substring(0, 13);

    setState(() {
      _customBrokerUid = customBrokerUid;
    });
    return print(customBrokerUid);
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.0),
                  Text(
                    'Broker Name',
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
                    controller: _brokerNameController,
                    focusNode: widget.brokerNameFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateField(
                      value: value,
                    ),
                    label: 'Broker Name',
                    hint: 'Enter broker name',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Type',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  BuildBrokerType(),
                  SizedBox(height: 24.0),
                  Text(
                    'Joined Date',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  BuildJoinedDate(),
                  SizedBox(height: 24.0),
                  Text(
                    'Logo Url',
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
                    controller: _logoUrlController,
                    focusNode: widget.logoUrlFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Logo Url',
                    hint: 'Enter broker\'s logo url',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Contact Phone',
                    style: TextStyle(
                      color: Palette.firebaseGrey,
                      fontSize: 16.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomNumberFormField(
                    isLabelEnabled: false,
                    controller: _phoneController,
                    focusNode: widget.phoneFocusNode,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Contact Phone',
                    hint: 'Enter broker\'s contact phone',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Contact Email',
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
                    controller: _emailController,
                    focusNode: widget.emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Contact',
                    hint: 'Enter broker\'s contact email',
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Country',
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
                    controller: _countryController,
                    focusNode: widget.countryFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) => DbValidator.validateNotRequired(
                      value: value,
                    ),
                    label: 'Country',
                    hint: 'Enter broker\'s country',
                  ),
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
                        widget.brokerNameFocusNode.unfocus();
                        widget.phoneFocusNode.unfocus();
                        widget.emailFocusNode.unfocus();
                        widget.joinedDateFocusNode.unfocus();
                        widget.logoUrlFocusNode.unfocus();
                        widget.countryFocusNode.unfocus();

                        // Call the function that set the _custombrokerUid parameter
                        getCustomBrokerUid();

                        if (_addItemFormKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });

                          await BrokerService(uid: currentUser!.uid).addBroker(
                            brokerUid: _customBrokerUid,
                            brokerName: _brokerNameController.text.trim(),
                            brokerType: _brokerType,
                            joinedDate: _joinedDateController.text,
                            logoUrl: _logoUrlController.text.trim(),
                            phone: _phoneController.text.trim(),
                            email: _emailController.text.trim(),
                            country: _countryController.text.trim(),
                            timeStamp: new DateTime.now().toString(),
                          );
                        }

                        setState(() {
                          _isProcessing = false;
                        });

                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'ADD BROKER',
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

  //
  List<String> brokerTypes = [
    'Forex',
    'Crypto',
    'Stocks',
    'Binary Options',
    'Others',
  ];
  Widget BuildBrokerType() => DropdownButtonFormField<String?>(
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
          labelStyle: TextStyle(color: Palette.firebaseYellow, fontSize: 16),
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
        value: _brokerType,
        items: brokerTypes.map((brokerType) {
          return DropdownMenuItem(
            value: brokerType,
            child: Text('$brokerType'),
          );
        }).toList(),
        onChanged: (String? val) => setState(() => _brokerType = val!),
      );

  // Joined Date
  Widget BuildJoinedDate() => TextField(
        controller: _joinedDateController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Palette.firebaseYellow,
          suffixIcon: Icon(
            Icons.calendar_today,
            color: Palette.firebaseNavy,
            size: 25,
          ),
          hintText: 'Select Date',
          labelStyle: TextStyle(color: Palette.firebaseYellow, fontSize: 16),
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
              firstDate: DateTime.parse('1980-01-01'),
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

            setState(() {
              _joinedDateController.text = formattedDate;
            });
          }
        },
      );
}
