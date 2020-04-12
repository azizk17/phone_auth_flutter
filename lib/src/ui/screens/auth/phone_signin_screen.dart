import 'package:app3/src/ui/screens/auth/pin_code_screen.dart';
import 'package:app3/src/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:app3/src/ui/widgets/phone_input.dart';
import 'package:app3/src/locale.dart';
import 'package:app3/src/states/states.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:app3/src/app/enums/enums.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '_errors.dart';

class PhoneSigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<PhoneAuthState>(context);

    /// navigate to pin code screen when code is sent successfuly
    if (authState.status == PhoneAuthStatus.CodeSent) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/auth/pinCode');
      });
    }

    return PhoneNumberScreen();
  }
}

class PhoneNumberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<PhoneAuthState>(context);
    Size size = MediaQuery.of(context).size;

    return AuthLayout(
      background: "assets/images/auth-bg.png",
      body: Container(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: size.height / 2.1,
              maxWidth: size.width / 1.13,
              // minHeight: MediaQuery.of(context).size.height / 1,
              // minWidth: MediaQuery.of(context).size.width / 1,
            ),
            padding: EdgeInsets.all(22),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(9))),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Text(authState.status.toString()),
                Text(AppLocalizations.of(context).enterYourPhoneMsg),
                SizedBox(height: 35),
                _phoneNumber(context),
                SizedBox(height: 35),
                Text(AppLocalizations.of(context).termsMsg),
                SizedBox(height: 35),
                Btn(
                  child: Text(AppLocalizations.of(context).btnSend),
                  loading: authState.status == PhoneAuthStatus.Progressing
                      ? true
                      : false,
                  onPressed: () =>
                      authState.verifyPhoneNumber(authState.phoneNumber),
                  enabled: authState.isPhoneNumberValid,
                ),
                authState.hasError
                    ? SnackBarLauncher(
                        error: errorText(context, authState.error))
                    : Container(),
                // _submitBtn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _phoneNumber(BuildContext context) {
    final authState = Provider.of<PhoneAuthState>(context);

    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        authState.setPhoneNumber(number.phoneNumber);
        print("phone number is : " + authState.phoneNumber);
      },
      onInputValidated: (val) => authState.validate(phoneNumber: val),
      isEnabled: authState.status == PhoneAuthStatus.Progressing ? false : true,
      autoValidate: true,
      formatInput: true,
      initialCountry2LetterCode: "SA",
      errorMessage: AppLocalizations.of(context).phoneFormatErr,
      inputDecoration: InputDecoration(
        // labelText: this.label,
        hintText: AppLocalizations.of(context).phone,
        // errorText: this.error,
        labelStyle: Theme.of(context)
            .inputDecorationTheme
            .labelStyle
            .copyWith(fontSize: 33),
        errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
        border: Theme.of(context).inputDecorationTheme.border,
      ),
    );
  }
}
