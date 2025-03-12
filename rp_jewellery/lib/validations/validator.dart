import 'package:rp_jewellery/extension/extensions.dart';

class Validator {
  static String? email(String? text) {
    if (text == null || text.isEmpty) {
      return 'Required Field';
    } else if (text.isValidEmail()) {
      return null;
    }
    return "Not valid Email";
  }

  static String? empty(String? text) {
    if (text == null || text.isEmpty) {
      return 'Required Field';
    }
    return null;
  }

  static String? password(String? text) {
    final String? emptyValidation = empty(text);
    if (emptyValidation != null) {
      return emptyValidation;
    }

    if (text!.length < 8) {
      return "Password must be at least 8 characters long";
    } else if (!RegExp(r'^(?=.*[A-Z])').hasMatch(text)) {
      return "Must contain at least one uppercase letter";
    } else if (!RegExp(r'^(?=.*[a-z])').hasMatch(text)) {
      return "Must contain at least one lowercase letter";
    } else if (!RegExp(r'^(?=.*\d)').hasMatch(text)) {
      return "Must contain at least one number";
    } else if (!RegExp(r'^(?=.*[@$!%*?&])').hasMatch(text)) {
      return "Must contain at least one special character (@\$!%*?&)";
    }

    return null;
  }

  static String? confirmPass(String pass, confirmpass) {
    final String? emptyValidation = empty(confirmpass);
    if (emptyValidation != null) {
      return emptyValidation;
    }
    if (empty(confirmpass) == null) {
      if (confirmpass != pass) {
        return "Passwords do not match!";
      }
    }
    return null;
  }
}
