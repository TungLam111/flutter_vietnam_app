import 'package:flutter_vietnam_app/utils/validation/validation_service.dart';

class ValidationServiceImpl implements ValidationService {
  static const int usernameMaxLength = 30;
  static const int passwordMinLength = 8;
  static const int passwordMaxLength = 100;

  @override
  String? validateEmail(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    String? errorMsg;

    if (email.isEmpty) {
      errorMsg = "Email can't be empty";
    }
    if (email.isEmpty || !regex.hasMatch(email)) {
      errorMsg = 'Enter Valid Email Id!!!';
    }
    return errorMsg;
  }

  @override
  String? validateUserUsername(String username) {
    String? errorMsg;

    if (username.isEmpty) {
      errorMsg = "Username can't be empty";
    } else if (!isUsernameAllowedLength(username)) {
      errorMsg = "Username can't surpass 30 characters";
    } else if (!isUsernameAllowedCharacters(username)) {
      errorMsg = "Username can't contain these character";
    }

    return errorMsg;
  }

  @override
  String? validateUserPassword(String password) {
    String? errorMsg;

    if (password.isEmpty) {
      errorMsg = "Password can't be empty";
    } else if (!isPasswordAllowedLength(password)) {
      errorMsg = 'Password must be > 10 and < 30';
    }

    return errorMsg;
  }

  @override
  bool isUsernameAllowedLength(String username) {
    return username.isNotEmpty && username.length <= usernameMaxLength;
  }

  @override
  bool isUsernameAllowedCharacters(String username) {
    String p = r'^[a-zA-Z0-9](?:[._]?[a-z-A-Z0-9])*$ ';

    RegExp regExp = RegExp(p, caseSensitive: false);

    return regExp.hasMatch(username);
  }

  @override
  bool isPasswordAllowedLength(String password) {
    return password.length >= passwordMinLength &&
        password.length <= passwordMaxLength;
  }
}
