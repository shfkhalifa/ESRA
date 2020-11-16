import 'package:esra/bloc/authenticationBloc/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esra/repositories/userRepository.dart';
import 'package:esra/bloc/registerBloc/register.dart';
import 'package:esra/components/registerWidget/registerForm.dart';

class RegisterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(context.repository<UserRepository>()),
        child: RegisterForm(),
      ),
    );
  }
}
