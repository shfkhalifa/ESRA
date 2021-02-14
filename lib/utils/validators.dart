class Validators {
  static final RegExp _emailRegExp = RegExp(
      r'^[a-zA-Z 0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)\s*$',
      caseSensitive: false);
  // static final RegExp _passwordRegExp = RegExp(
  //   r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  // );
  static final RegExp _textOnlyRegExp = RegExp(r'\s*^[a-zA-Z\s+]{3,}\s*$');
  //static final RegExp _dateOfBirthRegExp = RegExp(r'^[0-9]+$');
  static final RegExp _phoneNumberRegExp = RegExp(r'^[0-9]{8}$');

  static final RegExp _dateOfBirthRegExp = new RegExp(
    r"^(?:0[1-9]|[12]\d|3[01])([\/.-])(?:0[1-9]|1[012])\1(?:19|20)\d\d$",
    caseSensitive: true,
    multiLine: false,
  );

//method to calculate age on Today (in years)
  static bool _isAgeAppropriate(String input) {
    bool isAgeAppropriate = false;
    if (_dateOfBirthRegExp.hasMatch(input)) {
      DateTime _dateTime = DateTime(
        int.parse(input.substring(6)),
        int.parse(input.substring(3, 5)),
        int.parse(input.substring(0, 2)),
      );
      int age = DateTime.fromMillisecondsSinceEpoch(
                  DateTime.now().difference(_dateTime).inMilliseconds)
              .year -
          1970;
      if (age >= 3 && age <= 16) {
        print('child age is $age');
        isAgeAppropriate = true;
      } else {
        isAgeAppropriate = false;
      }
    }
    return isAgeAppropriate;
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
    return _dateOfBirthRegExp.hasMatch(dob) && _isAgeAppropriate(dob);
  }

  static isPhonNumberValid(String phoneNumber) {
    return _phoneNumberRegExp.hasMatch(phoneNumber);
  }
}
