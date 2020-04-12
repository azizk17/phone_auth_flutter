import 'dart:async';

import 'package:app3/src/app/enums/enums.dart';
import 'package:app3/src/models/user_model.dart';
import 'package:app3/src/services/firebase/_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class AuthFirebase {
  static var actualCode;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User> get authUser =>
      FirebaseAuth.instance.currentUser().then((u) => this._parse(u));
  Stream get onAuthChanged =>
      FirebaseAuth.instance.onAuthStateChanged.map((u) => this._parse(u));

  BehaviorSubject<PhoneAuthStatus> _phoneStatusSubject =
      BehaviorSubject<PhoneAuthStatus>();
  BehaviorSubject<AuthError> _authErrorSubject = BehaviorSubject<AuthError>();

  Stream<PhoneAuthStatus> get phoneAuthStatus => _phoneStatusSubject.stream;
  Stream<AuthError> get authError => _authErrorSubject.stream;

  AuthFirebase() {
    this._auth.setLanguageCode("ar");
  }

  Function get verifyPhoneNumber => _verifyPhoneNumber;

  User _parse(FirebaseUser fUser) {
    return User((b) => [
          b..id = fUser.uid,
          b..email = fUser.email,
          b..phone = fUser.phoneNumber,
          // b..profilePhoto = fUser.photoUrl,
          b..name = fUser.displayName
        ]);
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    // ? parsing is not recommend since the returned object has useful functions
    return _user;
  }

  ///
  /// # Verify phone number by sending a pin code
  ///
  Future<void> _verifyPhoneNumber(String phoneNumber,
      {bool isResent = false}) async {
    print("@@@@@ @@ _verifyPhoneNumber");
    // #codesent
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      actualCode = verificationId;

      /// use stream to update the status
      /// if code pin is resent
      if (isResent) {
        _phoneStatusSubject.sink.add(PhoneAuthStatus.CodeResent);
      } else {
        _phoneStatusSubject.sink.add(PhoneAuthStatus.CodeSent);
      }
    };

    /// # PhoneCodeAutoRetrievalTimeout
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      actualCode = verificationId;
      _phoneStatusSubject.sink.add(PhoneAuthStatus.AutoRetrievalTimeOut);
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      /// setStatus('${authException.message}');
      _phoneStatusSubject.add(PhoneAuthStatus.Failed);

      /// add error to errorSubjet
      _authErrorSubject.sink.add(getException(authException));
    };
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) {
      signInWithCode(credential: auth);
      // setStatus('Auto retrieving verification code');
    };

    /// notify user of request has been progressing
    _phoneStatusSubject.sink.add(PhoneAuthStatus.Progressing);

    /// # verifyPhoneNumber
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  ///
  ///
  ///
  ///
  Future<void> signInWithCode(
      {String smsCode, AuthCredential credential}) async {
    if (credential == null) {
      credential = PhoneAuthProvider.getCredential(
        verificationId: actualCode,
        smsCode: smsCode,
      );
    }

    /// notify user of sending status
    _phoneStatusSubject.sink.add(PhoneAuthStatus.Progressing);

    FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((AuthResult value) {
      if (value.user != null) {
        _phoneStatusSubject.add(PhoneAuthStatus.Successful);
      } else {
        _phoneStatusSubject.add(PhoneAuthStatus.Failed);
      }
    }).catchError((error) {
      _phoneStatusSubject.add(PhoneAuthStatus.Failed);
      _authErrorSubject.sink.add(getException(error));
      print(error.toString());
    });
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }

  void dispose() {
    this._phoneStatusSubject.close();
    this._authErrorSubject.close();
  }
}
