import 'package:flutter/material.dart';
import '../res/custom_colors.dart';

// ignore: must_be_immutable
class CustomSearchFormField extends StatelessWidget {
  var onChanged;

  CustomSearchFormField({
    Key? key,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required TextInputAction inputAction,
    required String label,
    required String hint,
    required Function(String value) validator,
    this.isObscure = false,
    this.isCapitalized = false,
    this.maxLines = 1,
    this.isLabelEnabled = false,
    initialData,
    required Function(String value) onChanged,
  })  : _emailController = controller,
        _keyboardtype = keyboardType,
        _inputAction = inputAction,
        _label = label,
        _hint = hint,
        _validator = validator,
        _onChanged = onChanged,
        super(key: key);

  final TextEditingController _emailController;
  final TextInputType _keyboardtype;
  final TextInputAction _inputAction;
  final String _label;
  final String _hint;
  final bool isObscure;
  final bool isCapitalized;
  final int maxLines;
  final bool isLabelEnabled;
  final Function(String) _validator;
  final Function(String) _onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: _emailController,
      onChanged: _onChanged,
      keyboardType: _keyboardtype,
      obscureText: isObscure,
      textCapitalization:
          isCapitalized ? TextCapitalization.words : TextCapitalization.none,
      textInputAction: _inputAction,
      cursorColor: Palette.firebaseYellow,
      validator: (value) => _validator(value!),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Palette.firebaseYellow),
        labelText: isLabelEnabled ? _label : null,
        labelStyle: TextStyle(color: Palette.firebaseYellow, fontSize: 16),
        hintText: _hint,
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
      style: TextStyle(color: Palette.firebaseYellow),
    );
  }
}
