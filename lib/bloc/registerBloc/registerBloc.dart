import 'dart:async';
import 'package:esra/bloc/authenticationBloc/authentication.dart';
import 'package:esra/utils/errorHandler.dart';
import 'package:bloc/bloc.dart';
import 'package:esra/bloc/registerBloc/register.dart';
import 'package:esra/repositories/userRepository.dart';
import 'package:esra/utils/validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc(UserRepository userRepository)
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PhoneNumberChanged) {
      yield* _mapPhoneNumberChangedToState(event.phoneNumber);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is RePasswordChanged) {
      yield* _mapRePasswordChangedToState(event.rePassword, event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password, event.phoneNumber);
    } else if (event is VerifyUser) {
      yield* _mapVerifyUserToSate(event.smsCode, event.email);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPhoneNumberChangedToState(String phoneNumber) async* {
    yield state.update(
      isPhoneNumberValid: Validators.isPhonNumberValid(phoneNumber),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapRePasswordChangedToState(String rePassword, String password) async* {
    yield state.update(
      isRePasswordValid: rePassword == password,
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String email,
    String password,
    String phoneNumber,
  ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.registerUser(
        email,
        password,
      );
      bool userIsVerified = await _userRepository.sendVerCode(phoneNumber: phoneNumber, email: email);
      if (userIsVerified)
        yield RegisterState.userVerified();
      else
        yield RegisterState.success();
    } on ErrorHandler catch (e) {
      yield RegisterState.failure(errorMsg: e.toString());
    }
  }

// if they enter the smsCode
  Stream<RegisterState> _mapVerifyUserToSate(String smsCode, String email) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.verifyPhoneNo(smsCode: smsCode, email: email);
      yield RegisterState.success();
    } on ErrorHandler catch (e) {
      yield RegisterState.failure(errorMsg: e.toString());
    }
  }
}
