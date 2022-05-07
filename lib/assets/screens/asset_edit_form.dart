import 'package:tradelait/assets/services/asset_service.dart';
import 'package:tradelait/widgets/custom_form_field.dart';
import 'package:tradelait/widgets/custom_number_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/services/validators/db_validator.dart';
import 'package:intl/intl.dart';

class AssetEditForm extends StatefulWidget {
  final FocusNode assetNameFocusNode;
  final FocusNode valuePurchasedFocusNode;
  final FocusNode valuePresentFocusNode;
  final FocusNode valueOneYearFocusNode;
  final FocusNode valueFiveYearsFocusNode;
  final FocusNode valueTenYearsFocusNode;
  //
  final String assetUid;
  final String currentAssetName;
  final String currentValuePurchased;
  final String currentValuePresent;
  final String currentValueOneYear;
  final String currentValueFiveYears;
  final String currentValueTenYears;
  final String currentCondition;
  final String currentPurpose;
  final String currentAssetGroup;
  final String currentAssetType;
  final String currentPurchasedDate;
  final String createdTimeStamp;
  final bool credit;

  const AssetEditForm(
      {required this.assetNameFocusNode,
      required this.valuePurchasedFocusNode,
      required this.valuePresentFocusNode,
      required this.valueOneYearFocusNode,
      required this.valueFiveYearsFocusNode,
      required this.valueTenYearsFocusNode,
      //
      required this.assetUid,
      required this.currentAssetName,
      required this.currentValuePurchased,
      required this.currentValuePresent,
      required this.currentValueOneYear,
      required this.currentValueFiveYears,
      required this.currentValueTenYears,
      required this.currentCondition,
      required this.currentPurpose,
      required this.currentAssetType,
      required this.currentAssetGroup,
      required this.currentPurchasedDate,
      required this.createdTimeStamp,
      required this.credit});

  @override
  _AssetEditFormState createState() => _AssetEditFormState();
}

class _AssetEditFormState extends State<AssetEditForm> {
  final _addItemFormKey = GlobalKey<FormState>();
  var currentUser = FirebaseAuth.instance.currentUser;
  bool _isProcessing = false;
  String _purpose = 'Business Facility';
  String _condition = 'Active';
  String _assetGroup = 'Appreciating';
  String _assetType = 'Building';

  //
  late TextEditingController _assetNameController;
  late TextEditingController _valuePurchasedController;
  late TextEditingController _valuePresentController;
  late TextEditingController _valueOneYearController;
  late TextEditingController _valueFiveYearsController;
  late TextEditingController _valueTenYearsController;
  late TextEditingController _purchasedDateController;

  // Initialisation
  @override
  void initState() {
    super.initState();

    _purpose = widget.currentPurpose;
    _condition = widget.currentCondition;
    _assetGroup = widget.currentAssetGroup;
    _assetType = widget.currentAssetType;

    _assetNameController = TextEditingController(
      text: widget.currentAssetName,
    );

    _valuePurchasedController = TextEditingController(
      text: widget.currentValuePurchased,
    );

    _valuePresentController = TextEditingController(
      text: widget.currentValuePresent,
    );

    _valueOneYearController = TextEditingController(
      text: widget.currentValueOneYear,
    );

    _valueFiveYearsController = TextEditingController(
      text: widget.currentValueFiveYears,
    );

    _valueTenYearsController = TextEditingController(
      text: widget.currentValueTenYears,
    );

    _purchasedDateController = TextEditingController(
      text: widget.currentPurchasedDate,
    );
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
                  'Asset Name',
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
                  controller: _assetNameController,
                  focusNode: widget.assetNameFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'Asset Name',
                  hint: 'Enter the asset name here',
                ),
                SizedBox(height: 20.0),
                Text(
                  'Asset Group',
                  style: TextStyle(
                    color: Palette.firebaseGrey,
                    fontSize: 16.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.0),
                BuildAssetGroup(),
                SizedBox(height: 20.0),
                Text(
                  'Asset Type',
                  style: TextStyle(
                    color: Palette.firebaseGrey,
                    fontSize: 16.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.0),
                BuildAssetType(),
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
                BuildPurpose(),
                SizedBox(height: 20.0),
                Text(
                  'Asset State',
                  style: TextStyle(
                    color: Palette.firebaseGrey,
                    fontSize: 16.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.0),
                BuildCondtion(),
                SizedBox(height: 20.0),
                Text(
                  'Purchased Date',
                  style: TextStyle(
                    color: Palette.firebaseGrey,
                    fontSize: 16.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.0),
                BuildPurchasedDate(),
                SizedBox(height: 20.0),
                Text(
                  'Purchased Value',
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
                  controller: _valuePurchasedController,
                  focusNode: widget.valuePurchasedFocusNode,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'Purchased Value',
                  hint: 'Enter the value at purchase',
                ),
                SizedBox(height: 20.0),
                Text(
                  'Present Value',
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
                  controller: _valuePresentController,
                  focusNode: widget.valuePresentFocusNode,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateField(
                    value: value,
                  ),
                  label: 'Present Value',
                  hint: 'Enter the present value',
                ),
                SizedBox(height: 20.0),
                Text(
                  'Value After One Year',
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
                  controller: _valueOneYearController,
                  focusNode: widget.valueOneYearFocusNode,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateNotRequired(
                    value: value,
                  ),
                  label: 'Value After One Year',
                  hint: 'Enter the value after one year',
                ),
                SizedBox(height: 20.0),
                Text(
                  'Value After Five Years',
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
                  controller: _valueFiveYearsController,
                  focusNode: widget.valueFiveYearsFocusNode,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateNotRequired(
                    value: value,
                  ),
                  label: 'Value After Five Years',
                  hint: 'Enter the value after five years',
                ),
                SizedBox(height: 20.0),
                Text(
                  'Value After Ten Year',
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
                  controller: _valueTenYearsController,
                  focusNode: widget.valueTenYearsFocusNode,
                  inputAction: TextInputAction.next,
                  validator: (value) => DbValidator.validateNotRequired(
                    value: value,
                  ),
                  label: 'Value After Ten Year',
                  hint: 'Enter the value after ten years',
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
                        widget.assetNameFocusNode.unfocus();
                        widget.valuePurchasedFocusNode.unfocus();
                        widget.valuePresentFocusNode.unfocus();
                        widget.valueOneYearFocusNode.unfocus();
                        widget.valueFiveYearsFocusNode.unfocus();
                        widget.valueTenYearsFocusNode.unfocus();

                        //
                        if (_addItemFormKey.currentState!.validate()) {
                          setState(() {
                            _isProcessing = true;
                          });
                          //

                          await AssetService(uid: currentUser!.uid).updateAsset(
                            assetUid: widget.assetUid,
                            assetName: _assetNameController.text,
                            valuePurchased: _valuePurchasedController.text,
                            valuePresent: _valuePresentController.text,
                            valueOneYear: _valueOneYearController.text,
                            valueFiveYears: _valueFiveYearsController.text,
                            valueTenYears: _valueTenYearsController.text,
                            condition: _condition,
                            purpose: _purpose,
                            assetGroup: _assetGroup,
                            assetType: _assetType,
                            purchasedDate: _purchasedDateController.text,
                            createdTimeStamp: widget.createdTimeStamp,
                            updatedTimeStamp: new DateTime.now().toString(),
                            credit: true,
                          );

                          setState(() {
                            _isProcessing = false;
                          });

                          Navigator.of(context).pop();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'EDIT ASSET',
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

  // Purposes dropdown item list
  final List<String> purposes = [
    'Business Facility',
    'Investment',
    'Others',
  ];
  Widget BuildPurpose() => DropdownButtonFormField(
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
        value: _purpose,
        items: purposes.map((purpose) {
          return DropdownMenuItem(
            value: purpose,
            child: Text('$purpose'),
          );
        }).toList(),
        onChanged: (String? val) => setState(() => _purpose = val!),
      );

  // condition of asset dropdown list
  final List<String> conditions = [
    'Active',
    'In Repair',
    'Inactive',
  ];
  Widget BuildCondtion() => DropdownButtonFormField(
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
        value: _condition,
        items: conditions.map((condition) {
          return DropdownMenuItem(
            value: condition,
            child: Text('$condition'),
          );
        }).toList(),
        onChanged: (String? val) => setState(() => _condition = val!),
      );

  // group of assets dropdown item list
  final List<String> assetGroups = [
    'Appreciating',
    'Depreciating',
  ];
  Widget BuildAssetGroup() => DropdownButtonFormField(
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
        value: _assetGroup,
        items: assetGroups.map((assetGroup) {
          return DropdownMenuItem(
            value: assetGroup,
            child: Text('$assetGroup'),
          );
        }).toList(),
        onChanged: (String? val) => setState(() => _assetGroup = val!),
      );

  // type of assets dropdown list
  final List<String> assetTypes = [
    'Building',
    'Vehicle',
    'Land',
    'Machine',
    'Bond',
    'Stock',
    'Equity',
    'Business',
    'Patent',
    'Copyright',
    'Publication',
    'Media'
  ];
  Widget BuildAssetType() => DropdownButtonFormField(
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
        value: _assetType,
        items: assetTypes.map((assetType) {
          return DropdownMenuItem(
            value: assetType,
            child: Text('$assetType'),
          );
        }).toList(),
        onChanged: (String? val) => setState(() => _assetType = val!),
      );

  // Purcahsed Date
  Widget BuildPurchasedDate() => TextField(
        controller: _purchasedDateController,
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
              firstDate: DateTime.parse('1980-1-1'),
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            print(pickedDate);
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            print(formattedDate);

            setState(() {
              _purchasedDateController.text = formattedDate;
            });
          } else {
            setState(() {
              _purchasedDateController.text =
                  DateTime.now().toString().split(" ")[0].toString();
            });
          }
        },
      );
}
