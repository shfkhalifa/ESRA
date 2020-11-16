class Validators {
  static final RegExp _emailRegExp = RegExp(
      r'^[a-zA-Z 0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
      caseSensitive: false);
  // static final RegExp _passwordRegExp = RegExp(
  //   r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  // );
  static final RegExp _textOnlyRegExp = RegExp(r'^[a-zA-Z ]{3,}$');
  static final RegExp _numbersOnlyRegExp = RegExp(r'^[0-9]+$');
  static final RegExp _phoneNumberRegExp = RegExp(r'^[0-9]{8}$');

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

  static isAgeValid(String age) {
    return _numbersOnlyRegExp.hasMatch(age) &&
        (int.parse(age) > 1) &&
        (int.parse(age) <= 18);
  }

  static isPhonNumberValid(String phoneNumber) {
    return _phoneNumberRegExp.hasMatch(phoneNumber);
  }
}
