import 'package:app3/src/locale.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:app3/src/app/enums/enums.dart';
import 'package:app3/src/states/states.dart';
import 'package:app3/src/ui/widgets/widgets.dart';

import '_errors.dart';

///
/// TODO: allow changing phone number or going back to phone number screen
///
class PinCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<PhoneAuthState>(context);

    // if (authState.hasError) {
    //   final snackBar = SnackBar(
    //     content: Text("Has Error"),
    //     backgroundColor: Colors.red,
    //   );
    //   Scaffold.of(context).showSnackBar(snackBar);
    // }

    if (authState.status == PhoneAuthStatus.Successful) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/');
      });
    }

    return AuthLayout(
      background: "assets/images/auth-bg.png",
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(AppLocalizations.of(context).phoneNumberVarificationMsg),
            SizedBox(height: 22),
            RichText(
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: AppLocalizations.of(context).enterVerifiCodeMsg),
                  new TextSpan(
                      text: " ${authState.phoneNumber}",
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 22),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 11),
                child: PinCodeTextField(
                  length: 6,
                  obsecureText: false,
                  textInputType: TextInputType.numberWithOptions(),
                  animationType: AnimationType.fade,
                  shape: PinCodeFieldShape.box,
                  animationDuration: Duration(milliseconds: 300),
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 45,
                  backgroundColor: Colors.transparent,
                  activeColor: Colors.white70,
                  inactiveColor: Colors.white70,
                  selectedColor: Colors.white,
                  disabledColor: Colors.grey.shade700,
                  inactiveFillColor: Colors.white70,
                  activeFillColor: Colors.white70,
                  selectedFillColor: Colors.white,
                  enableActiveFill: true,
                  enabled: true,

                  // controller: textEditingController,
                  onCompleted: authState.signInWithCode,
                  onChanged: (value) {
                    print(value);
                  },
                )),
            SizedBox(height: 22),
            authState.status == PhoneAuthStatus.Progressing
                ? CircularProgressIndicator()
                : Container(),
            authState.hasError
                ? SnackBarLauncher(error: errorText(context, authState.error))
                : Container(),
            _resend(context),
          ],
        ),
      ),
    );
  }

  Widget _resend(BuildContext context) {
    final authState = Provider.of<PhoneAuthState>(context);
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    TextStyle timerStyle = TextStyle(
        color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold);

    final _whichShow = authState.canResendCode;
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(
              text: "${AppLocalizations.of(context).waitResendMsg} ",
              style: defaultStyle),
          authState.canResendCode

              /// show resend button when time ended
              ? TextSpan(
                  text: "${AppLocalizations.of(context).btnResend}",
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()

                    /// disable resend buton on progressing
                    ..onTap = authState.status == PhoneAuthStatus.Progressing
                        ? null
                        : authState.resendPinCode)
              : TextSpan(
                  text: "${authState.countdown.toString()}", style: timerStyle),
        ],
      ),
    );
  }

  Widget _textLink(BuildContext context) {
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
    TextStyle linkStyle = TextStyle(color: Colors.blue);
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(text: 'By clicking Sign Up, you agree to our '),
          TextSpan(
              text: 'Terms of Service',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Terms of Service"');
                }),
          TextSpan(text: ' and that you have read our '),
          TextSpan(
              text: 'Privacy Policy',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Privacy Policy"');
                }),
        ],
      ),
    );
  }
}
