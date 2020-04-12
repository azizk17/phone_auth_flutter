// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  static m0(filed) => "${filed} is required";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "about" : MessageLookupByLibrary.simpleMessage("About"),
    "account" : MessageLookupByLibrary.simpleMessage("Account"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("My APP"),
    "btnAgree" : MessageLookupByLibrary.simpleMessage("Agree"),
    "btnCancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "btnLogin" : MessageLookupByLibrary.simpleMessage("Login"),
    "btnLogout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "btnRegister" : MessageLookupByLibrary.simpleMessage("Register"),
    "btnResend" : MessageLookupByLibrary.simpleMessage("Resend"),
    "btnSave" : MessageLookupByLibrary.simpleMessage("Save"),
    "btnSend" : MessageLookupByLibrary.simpleMessage("Send"),
    "contact" : MessageLookupByLibrary.simpleMessage("Contact us"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "emailIsUsed" : MessageLookupByLibrary.simpleMessage("This email has been used "),
    "emailNotValid" : MessageLookupByLibrary.simpleMessage("Email Address is not Valied"),
    "enterVerifiCodeMsg" : MessageLookupByLibrary.simpleMessage("Enter the code sent to"),
    "enterYourPhoneMsg" : MessageLookupByLibrary.simpleMessage("Enter your phone number"),
    "hello" : MessageLookupByLibrary.simpleMessage("Hello"),
    "incorrectCredentials" : MessageLookupByLibrary.simpleMessage("Credentials are not correct"),
    "intenetConnectionFaild" : MessageLookupByLibrary.simpleMessage("Connection is lost !!"),
    "intenetConnectionSuccess" : MessageLookupByLibrary.simpleMessage("You are connected"),
    "invalidPhoneNumber" : MessageLookupByLibrary.simpleMessage("phone number is incorrect"),
    "invalidVerifiCodeMsg" : MessageLookupByLibrary.simpleMessage("varification code is incorrect"),
    "isRequired" : m0,
    "lastLogin" : MessageLookupByLibrary.simpleMessage("Last Login"),
    "logoutMsg" : MessageLookupByLibrary.simpleMessage("You Logged Out"),
    "name" : MessageLookupByLibrary.simpleMessage("name"),
    "networkError" : MessageLookupByLibrary.simpleMessage("Please check your network !!"),
    "notifications" : MessageLookupByLibrary.simpleMessage("notifications"),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "passwordNotValid" : MessageLookupByLibrary.simpleMessage("Password must be in correct pattren"),
    "passwordRest" : MessageLookupByLibrary.simpleMessage("Forget Password"),
    "permissions" : MessageLookupByLibrary.simpleMessage("Permissions"),
    "phone" : MessageLookupByLibrary.simpleMessage("Phone Number"),
    "phoneFormatErr" : MessageLookupByLibrary.simpleMessage("Please enter a correct phone number"),
    "phoneNumberVarificationMsg" : MessageLookupByLibrary.simpleMessage("Phone Number Varification"),
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "profilePhoto" : MessageLookupByLibrary.simpleMessage("Profile Photo"),
    "registerAt" : MessageLookupByLibrary.simpleMessage("Joined At"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "sginInFaild" : MessageLookupByLibrary.simpleMessage(""),
    "sginInSuccess" : MessageLookupByLibrary.simpleMessage("You are logged in"),
    "share" : MessageLookupByLibrary.simpleMessage("Share"),
    "termsMsg" : MessageLookupByLibrary.simpleMessage("By creating an account, you are agreeing to our Terms of Service and Privacy Policy"),
    "termsOfService" : MessageLookupByLibrary.simpleMessage("Terms of Service"),
    "unknownError" : MessageLookupByLibrary.simpleMessage("Something Went Wrong !!"),
    "userNotFound" : MessageLookupByLibrary.simpleMessage("You Dont have account with this email"),
    "verifyEmail" : MessageLookupByLibrary.simpleMessage("Please Verify Your Email"),
    "verifyPhone" : MessageLookupByLibrary.simpleMessage("Please Verify Your Phone Number"),
    "waitResendMsg" : MessageLookupByLibrary.simpleMessage("Didn\'t recive the code?"),
    "youLoggedIn" : MessageLookupByLibrary.simpleMessage("You already logged in")
  };
}
