import 'package:app3/src/app/enums/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

// TODO: return message along with error type
AuthError getException(Exception e) {
  if (e is AuthException) {
    print("Error in exception: ${e.message}");
  }
  if (e is PlatformException) {
    switch (e.code) {
      case "ERROR_WRONG_PASSWORD":
        return AuthError.PasswordNotValid;
        break;
      case "ERROR_USER_NOT_FOUND":
        return AuthError.UserNotFound;
        break;
      case "ERROR_INVALID_VERIFICATION_CODE":
        return AuthError.InvalidVerficationCode;
      default:
        return AuthError.UnknownError;
    }
  } else {
    return AuthError.UnknownError;
  }
}
