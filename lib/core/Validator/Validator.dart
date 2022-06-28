class Validators {
  static String? _normalcheck(String? _val) {
    if (_val == null) {
      return 'Please fill the field';
    }
    if (_val.isEmpty) {
      return 'Please fill the field';
    }
    return null;
  }

  static String? nameValidator(String? _val) => _normalcheck(_val);

  static String? emailValidator(String? email) {
    if (_normalcheck(email) != null) {
      return 'Please fill the field';
    }

    bool _isReExpresionResult = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email!);

    if (!_isReExpresionResult) {
      return 'Enter correct Email Adress';
    }
    return null;
  }

  static String? phoneNumberCheck(String? _val) {
    if (_normalcheck(_val) != null) {
      return 'Please fill the field';
    }
    if (double.tryParse(_val!) == null) {
      return 'Enter Correct Mobile Number';
    }

    if (_val.length != 10) {
      return 'Enter Correct Mobile Number';
    }

    return null;
  }

  static String? passwordValidator(String? _val) {
    if (_normalcheck(_val) != null) {
      return 'Please fill the field';
    }

    if (_val!.length <= 5) {
      return 'Password must be greater than 6 length';
    }
    return null;
  }

  static String? usernameValidator(String? _val) {
    if (_normalcheck(_val) != null) {
      return 'Please fill the field';
    }
    bool _isValid = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(_val!);

    if (_isValid) {
      return 'Special characters not allowed';
    }
    return null;
  }
}
