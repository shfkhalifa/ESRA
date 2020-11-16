import 'package:esra/components/button.dart';
import 'package:esra/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esra/bloc/authenticationBloc/authentication.dart';
import 'package:esra/bloc/registerBloc/register.dart';

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _rePasswordController.text.isNotEmpty &&
      _phoneNumberController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPhoneNumberChanged);
    _passwordController.addListener(_onPasswordChanged);
    _rePasswordController.addListener(_onRePasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                duration: Duration(seconds: 10),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isUserVerified) {
          print("user has been automatically verified");
          Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
        }
        if (state.isSuccess) {
          // BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Map<String, String> creds = {
            "email": _emailController.text,
            "phone": _phoneNumberController.text
          };
          // Send verification code here
          //Navigator.of(context).pushNamed('/verifyPhoneNumber', arguments: creds);
          // TODO: we are temporarily skipping the user verification
          Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(state.errorMsg), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: Strings.EMAIL_LABEL,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  autovalidate: true,
                  validator: (_) {
                    return !state.isEmailValid ? Strings.INVALID_EMAIL : null;
                  },
                ),
                SizedBox(height: 24),

                ///
                /// Phone Number field
                ///
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: Strings.PHONE_NUMBER_LABEL,
                    helperText: Strings.PHONE_NUMBER_HELPER,
                    helperMaxLines: 2,
                    prefixText: "(+974) ",
                  ),
                  keyboardType: TextInputType.phone,
                  autocorrect: false,
                  autovalidate: true,
                  validator: (_) {
                    return !state.isPhoneNumberValid
                        ? Strings.INVALID_PHONE_NUMBER
                        : null;
                  },
                ),
                SizedBox(height: 24),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: Strings.PASSWORD_LABEL,
                  ),
                  obscureText: true,
                  autocorrect: false,
                  autovalidate: true,
                  validator: (_) {
                    return !state.isPasswordValid
                        ? Strings.INVALID_PASSWORD
                        : null;
                  },
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: _rePasswordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: Strings.REPASSWORD_LABEL,
                  ),
                  obscureText: true,
                  autocorrect: false,
                  autovalidate: true,
                  validator: (_) {
                    return !state.isRePasswordValid
                        ? Strings.INVALID_REPASSWORD
                        : null;
                  },
                ),
                SizedBox(height: 48),
                RoundButton(
                  label: Strings.REGISTER_BTN_TEXT,
                  onPressed:
                      isRegisterButtonEnabled(state) ? _onFormSubmitted : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPhoneNumberChanged() {
    _registerBloc.add(
      PhoneNumberChanged(phoneNumber: _phoneNumberController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onRePasswordChanged() {
    _registerBloc.add(
      RePasswordChanged(
        rePassword: _rePasswordController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _onFormSubmitted() {
    FocusScope.of(context).unfocus();
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
        phoneNumber: _phoneNumberController.text,
      ),
    );
  }
}
