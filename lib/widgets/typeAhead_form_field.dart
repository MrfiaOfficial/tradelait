//import 'dart:async';

import 'package:tradelait/fakeTypeAhead/city_fake_data.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// ignore: must_be_immutable
class TypeHeadFormField extends StatelessWidget {
  final TextEditingController controller;
  Function? serviceCall;
  //FutureOr<Iterable<String?>> serviceCall;
  String? selectedValue;
  String? labelText;

  TypeHeadFormField(
      {Key? key,
      this.serviceCall,
      this.selectedValue,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<String?>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        style: TextStyle(color: Palette.firebaseYellow),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Palette.firebaseYellow, fontSize: 16),
          border: OutlineInputBorder(),
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
      ),
      suggestionsCallback: CityData.getSuggestions,
      //suggestionsCallback: serviceCall,
      itemBuilder: (context, String? suggestion) => ListTile(
        title: Text(suggestion!),
      ),
      onSuggestionSelected: (String? suggestion) =>
          controller.text = suggestion!,
      validator: (value) => value != null && value.isEmpty
          ? 'Please select a ${labelText}'
          : null,
      onSaved: (value) => selectedValue = value,
    );
  }
}
