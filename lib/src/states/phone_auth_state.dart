import 'dart:async';

import 'package:app3/src/locale.dart';
import 'package:app3/src/states/states.dart';
import 'package:flutter/cupertino.dart';

import './base_state.dart';
import 'package:app3/src/app/enums/enums.dart';
import 'package:app3/src/services/firebase/auth_firebase.dart';
import 'package:meta/meta.dart';
import 'package:app3/src/models/models.dart';
import 'package:quiver/async.dart';

/// TODO:
//// hanedle errors
////fix assets
////resend
////clean errors messages when status change or text fileds change
//// timer
/// auth user
/// sign out

class PhoneAuthState extends BaseState {
  final _authService = AuthFirebase();

  /// get current authenticated user
  Future<User> get user => _authService.authUser;

  /// check is user authenticated
  bool get isAuth => true;
  PhoneAuthStatus _status;

  /// Status
  PhoneAuthStatus get status => _status;

  String _phoneNumber;
  String _pinCode;

  /// Error message
  AuthError _error;
  AuthError get error => _error;

  /// Pin code Resending Timer
  Timer _countdownTimer;
  int _countdown = 10;
  int get countdown => _countdown;
  bool _canResendCode = false;
  bool get canResendCode => _canResendCode;

  String get phoneNumber => _phoneNumber;
  String get pinCode => _pinCode;

  Function get setPhoneNumber => _setPhoneNumber;
  Function get setPinCode => _setPinCode;

  Function get verifyPhoneNumber => _verifyPhoneNumber;
  Function(String) get signInWithCode => _signInWithCode;
  Function get resendPinCode => _resendPinCode;
  Future<void> get signOut => _authService.signout();

  /// Validations
  Function get validate => _setValid;
  bool _isphoneNumberValid = false;
  bool _isPinCodeValid = false;
  bool get isPhoneNumberValid => _isphoneNumberValid;
  bool get isPinCodeValid => _isPinCodeValid;

  // shortcuts
  bool get isCodeSent => this.status == PhoneAuthStatus.CodeSent ? true : false;
  bool get hasError =>
      this.status == PhoneAuthStatus.Failed && this.error != null
          ? true
          : false;

  PhoneAuthState() {
    this.init();
    notifyListeners();
  }

  // setMsg(String msg) {}
  _setStatus(PhoneAuthStatus status) {
    this._status = status;
    notifyListeners();
  }

  _setValid({bool phoneNumber, bool pinCode}) {
    /// TODO: isolate validation in sepreate class instead of relaing on ui to do this job
    if (phoneNumber != null) {
      this._isphoneNumberValid = phoneNumber;
    }
    if (pinCode != null) {
      this._isPinCodeValid = pinCode;
    }
    notifyListeners();
  }

  _setPhoneNumber(String phoneNumber) {
    this._phoneNumber = phoneNumber;

    /// whenever a value changed error must be cleaned
    this.cleanErrors();
    notifyListeners();
  }

  _setPinCode(String pin) {
    this._pinCode = pin;

    /// whenever a value changed error must be cleaned
    this.cleanErrors();
    notifyListeners();
  }

  _setError(AuthError error) {
    this._error = error;
    notifyListeners();
  }

  void init() {
    this.reset();

    /// listen to streams for authservices
    this._authService.phoneAuthStatus.listen((s) {
      this._setStatus(s);

      /// when code is sent, start a timer to notify ui of reminig time until pin code can be sent agin
      if (s == PhoneAuthStatus.CodeSent || s == PhoneAuthStatus.CodeResent) {
        this.startTimer();
      }

      /// clean up errors every time a status has changed
      this.cleanErrors();
    });

    /// listen for errors
    this._authService.authError.listen((e) {
      this._setError(e);
    });
  }

  ///
  ///  # First phone number must be verified,
  ///  then _signInWithCode should be called
  /// * Errors and status are hendled on authServices.
  ///
  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    await this._authService.verifyPhoneNumber(phoneNumber);
  }

  ///  No need to handle errors or update the status for now.
  /// * Errors and status has been hendled on authServices.
  Future<void> _signInWithCode(String smsCode) async =>
      await this._authService.signInWithCode(smsCode: smsCode);

  ///
  /// # Resend Pin code
  ///
  Future<void> _resendPinCode() async {
    await this._authService.verifyPhoneNumber(this.phoneNumber, isResent: true);
  }

  ///
  /// For testing
  ///
  Future<PhoneAuthStatus> mockSginin({String id}) async {
    _setStatus(PhoneAuthStatus.Progressing);
    // User u = User((b) => [
    //       b..id = '22Test',
    //       b..name = 'aziz',
    //       b..email = 'aziz@aziz.com',
    //       b..phone = '000989732',
    //     ]);
    await Future.delayed(const Duration(milliseconds: 2000));
    var status = PhoneAuthStatus.CodeSent; // or faild
    _setStatus(status);
    return Future.value(status);
  }

  void startTimer() {
    const timeOutInSeconds = 10;
    const stepInSeconds = 1;
    int currentNumber = 0;
    this._canResendCode = false;

    CountdownTimer countDownTimer = new CountdownTimer(
        new Duration(seconds: timeOutInSeconds),
        new Duration(seconds: stepInSeconds));

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      currentNumber += stepInSeconds;
      int countdownNumber = timeOutInSeconds - currentNumber;

      /// Make it start from the timeout value
      countdownNumber += stepInSeconds;
      this._countdown = countdownNumber;
      notifyListeners();
    });

    sub.onDone(() {
      this._canResendCode = true;
      this._countdown = 0;
      notifyListeners();

      sub.cancel();
    });
  }

  ///
  /// clean up
  ///
  void cleanErrors() {
    /// TODO: clean validation errors as well
    if (this.error != null) {
      this._setError(null);
      notifyListeners();
    }
  }

  void reset() {
    this.setPhoneNumber(null);
    this._setStatus(PhoneAuthStatus.Started);
    this._setError(null);

    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _countdownTimer.cancel();
    super.dispose();
  }
}
