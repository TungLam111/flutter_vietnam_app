import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vietnam_app/repository/auth_repo/auth_repo.dart';
import 'package:flutter_vietnam_app/utils/logg.dart';
import 'package:flutter_vietnam_app/utils/validation/validation_service.dart';

class LoginScreenViewModel extends ChangeNotifier {
  LoginScreenViewModel(this._authRepository, this._validationService);

  final AuthRepository _authRepository;
  final ValidationService _validationService;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _passwordIsVisible = false;
  String? _loginFeedback;
  bool _loginInProgress = false;

  String _errorMessage = '';
  String _successMessage = '';

  final StreamController<bool> _isLoginSuccess = StreamController<bool>()
    ..add(false);

  Stream<bool> get isLoginSuccess => _isLoginSuccess.stream;

  void init() {
    _usernameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  GlobalKey<FormState> get getFormKey => _formKey;
  TextEditingController get getUsernameController => _usernameController;
  TextEditingController get getPasswordController => _passwordController;
  FocusNode get getPasswordFocusNode => _passwordFocusNode;
  bool get getPasswordIsVisible => _passwordIsVisible;
  String? get getLoginFeedback => _loginFeedback;
  bool? get getLoginInProgess => _loginInProgress;

  String get getErrorMessage => _errorMessage;
  String get getsuccessMessage => _successMessage;

  bool _validateForm() {
    if (_loginFeedback != null) {
      setLoginFeedback(null);
    }
    return _formKey.currentState!.validate();
  }

  void setLoginFeedback(String? feedback) {
    _loginFeedback = feedback;
    notifyListeners();
  }

  Future<String> signIn() async {
    try {
      String emailId = _usernameController.text;
      String password = _passwordController.text;

      User? user = await _authRepository.loginWithFirebase(
        emailId: emailId,
        password: password,
      );

      if (user == null) {
        return Future<String>.value('');
      }

      final User? currentUser =
          await _authRepository.getCurrentUserWithFirebase();
      _authRepository.setCurrentUser(currentUser);

      if (currentUser == null) {
        return Future<String>.value('');
      }

      _isLoginSuccess.add(true);
      assert(user.uid == currentUser.uid);
      return user.uid;
    } catch (e) {
      handleError(e as PlatformException);
      return '';
    }
  }

  handleError(PlatformException error) {
    logg(error);
    switch (error.code) {
      case 'ERROR_USER_NOT_FOUND':
        _errorMessage = 'User Not Found!!!';
        notifyListeners();
        break;
      case 'ERROR_WRONG_PASSWORD':
        _errorMessage = 'Wrong Password!!!';
        notifyListeners();
        break;
    }
  }

  String? validateEmail(String? value) {
    if (value == null) {
      return null;
    }
    return _validationService.validateEmail(value);
  }

  String? validatePassword(String? value) {
    if (value == null) {
      return null;
    }
    return _validationService.validateUserPassword(value);
  }

  void togglePasswordVisibility() {
    _passwordIsVisible = !_passwordIsVisible;
    notifyListeners();
  }

  void setLoginInProgress(bool loginInProgress) {
    _loginInProgress = loginInProgress;
    notifyListeners();
  }

  void setSuccessMessage(String msg) {
    _successMessage = msg;
    notifyListeners();
  }
}
