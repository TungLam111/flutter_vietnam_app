import 'package:flutter_vietnam_app/services/validation/validation_service.dart';

class ValidationServiceImpl implements ValidationService {
  static const int USERNAME_MAX_LENGTH = 30;
  static const int PASSWORD_MIN_LENGTH = 8;
  static const int PASSWORD_MAX_LENGTH = 100;

  String validateEmail(String email) {
    assert(email != null);
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    String errorMsg;
    
    if (errorMsg.length == 0){
      errorMsg = "Email can't be empty";
    }
    if (email.isEmpty || !regex.hasMatch(email))
      errorMsg = 'Enter Valid Email Id!!!';
    return errorMsg;
  }

  String validateUserUsername(String username) {
    assert(username != null);

    String errorMsg;

    if (username.length == 0) {
      errorMsg = "Username can't be empty";
    } else if (!isUsernameAllowedLength(username)) {
      errorMsg = "Username can't surpass 30 characters";
    } else if (!isUsernameAllowedCharacters(username)) {
      errorMsg = "Username can't contain these character";
    }

    return errorMsg;
  }

  String validateUserPassword(String password) {
    assert(password != null);

    String errorMsg;

    if (password.length == 0) {
      errorMsg = "Password can't be empty";
    } else if (!isPasswordAllowedLength(password)) {
      errorMsg = "Password must be > 10 and < 30";
    }

    return errorMsg;
  }

  bool isUsernameAllowedLength(String username) {
    return username.length > 0 && username.length <= USERNAME_MAX_LENGTH;
  }

  bool isUsernameAllowedCharacters(String username) {
    String p = r'^[a-zA-Z0-9](?:[._]?[a-z-A-Z0-9])*$ ';

    RegExp regExp = new RegExp(p, caseSensitive: false);

    return regExp.hasMatch(username);
  }

  bool isPasswordAllowedLength(String password) {
    return password.length >= PASSWORD_MIN_LENGTH &&
        password.length <= PASSWORD_MAX_LENGTH;
  }
}
