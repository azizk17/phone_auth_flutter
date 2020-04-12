import 'package:app3/src/app/enums/enums.dart';
import 'package:app3/src/locale.dart';
import 'package:flutter/widgets.dart';

String errorText(BuildContext context, AuthError e) {
  switch (e) {
    case AuthError.UserNotFound:
      return AppLocalizations.of(context).incorrectCredentials;
      break;
    case AuthError.EmailNotValid:
      return AppLocalizations.of(context).incorrectCredentials;
      break;
    case AuthError.InvalidVerficationCode:
      return AppLocalizations.of(context).invalidVerifiCodeMsg;
      break;
    case AuthError.NetworkError:
      return AppLocalizations.of(context).networkError;
      break;
    default:
      return AppLocalizations.of(context).unknownError;
  }
}
