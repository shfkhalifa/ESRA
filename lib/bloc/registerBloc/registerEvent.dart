import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

// class PhoneNumberChanged extends RegisterEvent {
//   final String phoneNumber;

//   const PhoneNumberChanged({@required this.phoneNumber});

//   @override
//   List<Object> get props => [phoneNumber];

//   @override
//   String toString() => 'PhoneNumberChanged { phoneNumber :$phoneNumber }';
// }

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class RePasswordChanged extends RegisterEvent {
  final String password;
  final String rePassword;

  const RePasswordChanged({@required this.rePassword, @required this.password});

  @override
  List<Object> get props => [rePassword, password];

  @override
  String toString() =>
      'PasswordChanged { rePassword: $rePassword, password: $password }';
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;
  //final String phoneNumber;

  //const Submitted({@required this.email, @required this.password, @required this.phoneNumber});
  const Submitted({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password}';
  }
}

class VerifyUser extends RegisterEvent {
  final String smsCode;
  final String email;
  const VerifyUser({@required this.smsCode, @required this.email});
  @override
  List<Object> get props => [smsCode, email];

  @override
  String toString() {
    return 'VerifyUser { smsCode: $smsCode, email: $email }';
  }
}
