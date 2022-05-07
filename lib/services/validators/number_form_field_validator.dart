class NumValidator {
  static String? validateNum({required num value}) {
    if (value.toString().isEmpty) {
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
}
