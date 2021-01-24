class Validators {
  static final RegExp _emailRegExp = RegExp(
      r'^[a-zA-Z 0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
      caseSensitive: false);
  // static final RegExp _passwordRegExp = RegExp(
  //   r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  // );
  static final RegExp _textOnlyRegExp = RegExp(r'^[a-zA-Z ]{3,}$');
  //static final RegExp _dateOfBirthRegExp = RegExp(r'^[0-9]+$');
  static final RegExp _phoneNumberRegExp = RegExp(r'^[0-9]{8}$');

  static final RegExp _dateOfBirthRegExp = new RegExp(
    r"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$",
    caseSensitive: true,
    multiLine: false,
  );

//method to calculate age on Today (in years)
  int ageCalculate(String input) {
    if (_dateOfBirthRegExp.hasMatch(input)) {
      DateTime _dateTime = DateTime(
        int.parse(input.substring(6)),
        int.parse(input.substring(3, 5)),
        int.parse(input.substring(0, 2)),
      );
      return DateTime.fromMillisecondsSinceEpoch(
                  DateTime.now().difference(_dateTime).inMilliseconds)
              .year -
          1970;
    } else {
      return -1;
    }
  }

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    // return _passwordRegExp.hasMatch(password);
    return password.length >= 6;
  }

  static isNameValid(String name) {
    return _textOnlyRegExp.hasMatch(name);
  }

  static isDOBValid(String dob) {
    return _dateOfBirthRegExp.hasMatch(dob);
  }

  static isPhonNumberValid(String phoneNumber) {
    return _phoneNumberRegExp.hasMatch(phoneNumber);
  }
}
