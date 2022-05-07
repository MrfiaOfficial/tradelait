class DbValidator {
  static String? validateField({required String value}) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    }

    return null;
  }

  static String? validateNotRequired({required String value}) {
    /* if (value.isEmpty) {
      return 'Field can\'t be empty';
    } */

    return null;
  }

  static String? validateUserID({required String uid}) {
    if (uid.isEmpty) {
      return 'User ID can\'t be empty';
    } else if (uid.length <= 3) {
      return 'User ID should be greater than 3 characters';
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePhone({required String phone}) {
    //String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    String patttern = r'(^(?:[+0])?[0-9]{11,14}$)';
    RegExp phoneRegExp = new RegExp(patttern);
    if (phone.length == 0) {
      return 'Please enter mobile number';
    } else if (!phoneRegExp.hasMatch(phone)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
