import 'package:app3/src/app/enums/enums.dart';
import 'package:app3/src/models/models.dart';
import 'package:app3/src/validations/base_validation.dart';
import 'package:app3/src/validations/errors_validation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:validators/validators.dart';

class UsersValidation extends BaseValidation {
  // get addError => addError;
  /**
   * 
   * overide a check function - BaseValidation
   */
  
  @override
  FormError check(String field, User user) {
    switch (field) {
      case "name":
        if (user.name.length < 3) {
          return FormError(key: field, message: "Email is very long");
        }
        break;
      case "email":
        if (user.email.length < 3) {}
        if (user.email.length > 6) {
          addError(
              key: "email", code: "EMALEE WN", message: "EMAIL is very long");
        }
        break;
      default:
        print("NO ERRORS");
        return null;
    }
  }
}
