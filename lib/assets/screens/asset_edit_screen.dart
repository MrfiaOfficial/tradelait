import 'package:tradelait/assets/screens/asset_add_form.dart';
import 'package:tradelait/assets/screens/asset_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class AssetEditScreen extends StatefulWidget {
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

  AssetEditScreen({
    required this.assetUid,
    required this.currentAssetName,
    required this.currentValuePurchased,
    required this.currentValuePresent,
    required this.currentValueOneYear,
    required this.currentValueFiveYears,
    required this.currentValueTenYears,
    required this.currentCondition,
    required this.currentPurpose,
    required this.currentAssetGroup,
    required this.currentAssetType,
    required this.currentPurchasedDate,
    required this.createdTimeStamp,
    required this.credit,
  });

  @override
  State<AssetEditScreen> createState() => _AssetEditScreenState();
}

class _AssetEditScreenState extends State<AssetEditScreen> {
  final FocusNode _assetNameFocusNode = FocusNode();
  final FocusNode _valuePresentFocusNode = FocusNode();
  final FocusNode _valuePurcahsedFocusNode = FocusNode();
  final FocusNode _valueOneYearFocusNode = FocusNode();
  final FocusNode _valueFiveYearsFocusNode = FocusNode();
  final FocusNode _valueTenYearsFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _assetNameFocusNode.unfocus();
        _valuePurcahsedFocusNode.unfocus();
        _valuePresentFocusNode.unfocus();
        _valueOneYearFocusNode.unfocus();
        _valueFiveYearsFocusNode.unfocus();
        _valueTenYearsFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.firebaseNavy,
          title: AppBarTitle(
            sectionName: 'Edit Asset',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: AssetEditForm(
              assetNameFocusNode: _assetNameFocusNode,
              valuePurchasedFocusNode: _valuePurcahsedFocusNode,
              valuePresentFocusNode: _valuePresentFocusNode,
              valueOneYearFocusNode: _valueOneYearFocusNode,
              valueFiveYearsFocusNode: _valueFiveYearsFocusNode,
              valueTenYearsFocusNode: _valueTenYearsFocusNode,
              //
              assetUid: widget.assetUid,
              currentAssetName: widget.currentAssetName,
              currentValuePurchased: widget.currentValuePurchased,
              currentValuePresent: widget.currentValuePresent,
              currentValueOneYear: widget.currentValueOneYear,
              currentValueFiveYears: widget.currentValueFiveYears,
              currentValueTenYears: widget.currentValueTenYears,
              currentCondition: widget.currentCondition,
              currentPurpose: widget.currentPurpose,
              currentAssetGroup: widget.currentAssetGroup,
              currentAssetType: widget.currentAssetType,
              currentPurchasedDate: widget.currentPurchasedDate,
              createdTimeStamp: widget.createdTimeStamp,
              credit: true,
            ),
          ),
        ),
      ),
    );
  }
}
