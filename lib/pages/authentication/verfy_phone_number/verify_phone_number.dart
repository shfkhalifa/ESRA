import 'package:division/division.dart';
import 'package:esra/bloc/authenticationBloc/authentication.dart';
import 'package:esra/bloc/registerBloc/register.dart';
import 'package:esra/repositories/userRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../styles.dart';

///
/// Varification Screen
/// This will be presented to users when they hit the register button,
/// meanwhile they should've received an sms with the verfication code.
/// Here, they need to enter that code!
///
class VerifyPhoneNumber extends StatefulWidget {
  final bool hasError;
  final String phoneNumber;
  final String email;
  VerifyPhoneNumber(
      {Key key,
      this.hasError = false,
      @required this.phoneNumber,
      @required this.email})
      : super(key: key);

  @override
  _VerifyPhoneNumberState createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  bool hasError = false;
  String currentText = "";
  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(context.repository<UserRepository>());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        bloc: _registerBloc,
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
                      Text('Activating...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          }
          if (state.isSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
          }
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMsg),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          bloc: _registerBloc,
          builder: (context, state) {
            return SafeArea(
              child: Parent(
                style: ParentStyle()
                  ..padding(all: 24)
                  ..height(MediaQuery.of(context).size.height)
                  ..alignmentContent.center(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Parent(
                        style: ParentStyle()..margin(bottom: 24),
                        child: Image(
                          image: AssetImage(AppIllustrations.addChild),
                          // width: 300,
                        ),
                      ),
                      Txt(
                        'Activate Your Account!',
                        style: TxtStyle()
                          ..textAlign.center()
                          ..fontSize(24)
                          ..margin(bottom: 8)
                          ..bold(),
                      ),
                      Txt('Enter the verification code sent to +974${widget.phoneNumber}'),

                      Parent(
                        style: ParentStyle()..margin(vertical: 24),
                        child: PinCodeTextField(
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(15),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                          ),
                          length: 6,
                          obsecureText: false,
                          textInputType: TextInputType.number,
                          animationType: AnimationType.scale,
                          animationDuration: Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          onCompleted: (value) {
                            //print(value);
                            _registerBloc.add(VerifyUser(
                                smsCode: value, email: widget.email));
                          },
                          onChanged: (value) {
                            setState(() {
                              currentText = value;
                            });
                            // BlocProvider.of<RegisterBloc>(context).add(VerifyUser(smsCode: value, email: widget.email));
                          },
                        ),
                      ),

                      // --> Resend verification code
                      widget.hasError
                          ? Parent(
                              gesture: Gestures()
                                ..onTap(() {
                                  // BlocProvider.of<RegisterBloc>(context).add(
                                  //   ReSendVerificationCode(phoneNumber: widget.phoneNumber),
                                  // );
                                }),
                              style: ParentStyle()
                                ..background.color(Colors.orange)
                                ..padding(vertical: 12, horizontal: 24)
                                ..margin(top: 24)
                                ..borderRadius(all: 24)
                                ..ripple(true),
                              child: Txt('RESEND VERIFICATION CODE',
                                  style: TxtStyle()
                                    ..textColor(Colors.white)
                                    ..bold()),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
