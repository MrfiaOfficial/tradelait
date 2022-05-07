import 'package:tradelait/students/services/student_service.dart';
import 'package:tradelait/widgets/typeAhead_form_field.dart';
import 'package:tradelait/res/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tradelait/fakeTypeAhead/food_fake_data.dart';
import 'package:tradelait/fakeTypeAhead/button_fake.dart';

class FormTypeAheadPage extends StatefulWidget {
  @override
  _FormTypeAheadPageState createState() => _FormTypeAheadPageState();
}

class _FormTypeAheadPageState extends State<FormTypeAheadPage> {
  final formKey = GlobalKey<FormState>();
  final controllerCity = TextEditingController();
  final controllerFood = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;

  String? selectedCity;
  String? selectedFood;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(24),
            color: Palette.firebaseNavy,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildCity(),
                    SizedBox(height: 16),
                    buildFood(),
                    SizedBox(height: 12),
                    buildSubmit(context),
                    SizedBox(height: 12),
                    TypeHeadFormField(
                      selectedValue: selectedCity,
                      controller: controllerCity,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildCity() => TypeAheadFormField<String?>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: controllerCity,
          style: TextStyle(color: Palette.firebaseYellow),
          decoration: InputDecoration(
            labelText: 'City',
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
        //suggestionsCallback: CityData.getSuggestions,
        suggestionsCallback: StudentService2(currentUser!.uid).futureStuds
            as Future<Iterable<String>> Function(String),
        itemBuilder: (context, String? suggestion) => ListTile(
          title: Text(suggestion!),
        ),
        onSuggestionSelected: (String? suggestion) =>
            controllerCity.text = suggestion!,
        validator: (value) =>
            value != null && value.isEmpty ? 'Please select a city' : null,
        onSaved: (value) => selectedCity = value,
      );

  Widget buildFood() => TypeAheadFormField<String?>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: controllerFood,
          decoration: InputDecoration(
            labelText: 'Food',
            border: OutlineInputBorder(),
          ),
        ),
        suggestionsCallback: FoodData.getSuggestions,
        itemBuilder: (context, String? suggestion) => ListTile(
          title: Text(suggestion!),
        ),
        onSuggestionSelected: (String? suggestion) =>
            controllerFood.text = suggestion!,
        validator: (value) =>
            value != null && value.isEmpty ? 'Please select a food' : null,
        onSaved: (value) => selectedFood = value,
      );

  Widget buildSubmit(BuildContext context) => ButtonWidget(
        text: 'Submit',
        onClicked: () {
          final form = formKey.currentState!;

          if (form.validate()) {
            form.save();

            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(
                    'Your Favourite City is $selectedCity\nYour Favourite Food is $selectedFood'),
              ));
          }
        },
      );
}
