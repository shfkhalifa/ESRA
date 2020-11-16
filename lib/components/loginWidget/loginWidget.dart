import 'package:esra/bloc/authenticationBloc/authenticationBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esra/repositories/userRepository.dart';
import 'package:esra/bloc/loginBloc/login.dart';
import 'package:esra/components/loginWidget/loginForm.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) =>
          LoginBloc(context.repository<UserRepository>(), BlocProvider.of<AuthenticationBloc>(context)),
      child: LoginForm(),
    );
  }
}
