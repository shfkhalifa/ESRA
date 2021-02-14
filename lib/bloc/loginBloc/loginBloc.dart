import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:esra/bloc/authenticationBloc/authentication.dart';
import 'package:esra/bloc/loginBloc/login.dart';
import 'package:esra/repositories/userRepository.dart';
import 'package:esra/utils/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;
  AuthenticationBloc _authenticationBloc;

  LoginBloc(
    UserRepository userRepository,
    AuthenticationBloc authenticationBloc,
  )   : assert(userRepository != null),
        _userRepository = userRepository,
        _authenticationBloc = authenticationBloc;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapSubmittedToState(
        email: event.email.trim(),
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapSubmittedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      await _userRepository.login(email, password);
      _authenticationBloc.add(LoggedIn());
      yield LoginState.success();
    } catch (e) {
      yield LoginState.failure(errorMsg: e.toString());
    }
  }
}
