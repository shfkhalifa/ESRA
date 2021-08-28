import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isEmailValid;
  //final bool isPhoneNumberValid;
  final bool isPasswordValid;
  final bool isRePasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isUserVerified;
  final bool isFailure;
  final String errorMsg;

  // bool get isFormValid => isEmailValid && isPhoneNumberValid && isPasswordValid && isRePasswordValid;
  bool get isFormValid => isEmailValid && isPasswordValid && isRePasswordValid;

  RegisterState({
    @required this.isEmailValid,
    //@required this.isPhoneNumberValid,
    @required this.isPasswordValid,
    @required this.isRePasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isUserVerified,
    @required this.isFailure,
    this.errorMsg,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isEmailValid: true,
      //isPhoneNumberValid: true,
      isPasswordValid: true,
      isRePasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isUserVerified: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isEmailValid: true,
      //isPhoneNumberValid: true,
      isPasswordValid: true,
      isRePasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isUserVerified: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure({String errorMsg}) {
    return RegisterState(
      isEmailValid: true,
      //isPhoneNumberValid: true,
      isPasswordValid: true,
      isRePasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isUserVerified: false,
      isFailure: true,
      errorMsg: errorMsg,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isEmailValid: true,
      //isPhoneNumberValid: true,
      isPasswordValid: true,
      isRePasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isUserVerified: false,
      isFailure: false,
    );
  }
  factory RegisterState.userVerified() {
    return RegisterState(
      isEmailValid: true,
      //isPhoneNumberValid: true,
      isPasswordValid: true,
      isRePasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isUserVerified: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isRePasswordValid,
    bool isPhoneNumberValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPhoneNumberValid: isPhoneNumberValid,
      isPasswordValid: isPasswordValid,
      isRePasswordValid: isRePasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isUserVerified: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isEmailValid,
    bool isPhoneNumberValid,
    bool isPasswordValid,
    bool isRePasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isUserVerified,
    bool isFailure,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      //isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isRePasswordValid: isRePasswordValid ?? this.isRePasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isUserVerified: isUserVerified ?? this.isUserVerified,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isEmailValid: $isEmailValid,
      
      isPasswordValid: $isPasswordValid,
      isRePasswordValid: $isRePasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isUserVerified: $isUserVerified,
      isFailure: $isFailure,
    }''';
  }
}
