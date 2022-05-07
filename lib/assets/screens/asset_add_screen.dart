import 'package:tradelait/assets/screens/asset_add_form.dart';
import 'package:flutter/material.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:tradelait/widgets/app_bar_title.dart';

class AssetAddScreen extends StatelessWidget {
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
            sectionName: 'Add Asset',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: AssetAddForm(
              assetNameFocusNode: _assetNameFocusNode,
              valuePurchasedFocusNode: _valuePurcahsedFocusNode,
              valuePresentFocusNode: _valuePresentFocusNode,
              valueOneYearFocusNode: _valueOneYearFocusNode,
              valueFiveYearsFocusNode: _valueFiveYearsFocusNode,
              valueTenYearsFocusNode: _valueTenYearsFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
