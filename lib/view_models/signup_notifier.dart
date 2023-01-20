import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vietnam_app/repository/auth_repo/auth_repo.dart';
import 'package:flutter_vietnam_app/utils/logg.dart';
import 'package:flutter_vietnam_app/utils/validation/validation_service.dart';

class SignupScreenViewModel extends ChangeNotifier {
  SignupScreenViewModel(
    this._authRepository,
    this._validationService,
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late bool _isSubmitted;
  String? _loginFeedback;
  late bool _signUpProgress;

  final ValidationService _validationService;
  final AuthRepository _authRepository;

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;

  String errorMessage = '';
  String successMessage = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> get getFormKey => _formKey;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get passwordConfirmController =>
      _passwordConfirmController;
  bool get signUpProgress => _signUpProgress;

  void init() {
    _signUpProgress = false;
    _isSubmitted = false;

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();

    _usernameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _passwordConfirmController.addListener(_validateForm);
  }

  Future<User?> signupWithFirebase() async {
    _setSignUpProgress(true);
    try {
      User? user = await _authRepository.signupWithFirebase(
        emailId: _usernameController.text,
        password: _passwordController.text,
      );
      if (user == null) {
        return user;
      }

      logg(user.getIdToken());
      return user;
    } catch (e) {
      handleError(e as PlatformException);
      return null;
    }
  }

  handleError(PlatformException error) {
    logg(error);
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        errorMessage = 'Email Id already Exist!!!';
        notifyListeners();
        break;
      default:
    }
  }

  Future<void> submitForm() async {
    _isSubmitted = true;
    if (_validateForm()) {
      await signupWithFirebase();
    }
  }

  String? validateEmail(String? value) {
    if (value == null) return value;
    if (!_isSubmitted) return null;
    return _validationService.validateEmail(value);
  }

  String? validatePassword(String? value) {
    if (value == null) return value;
    if (!_isSubmitted) return null;

    return _validationService.validateUserPassword(value);
  }

  String? validateConfirmPassword(String? value) {
    if (value == null) return value;
    if (!_isSubmitted) return null;

    if (value != _passwordController.text) {
      return 'Confirm passowrd must be same with passowrd';
    }
    return null;
  }

  bool _validateForm() {
    if (_loginFeedback != null) {
      _setLoginFeedback(null);
    }
    return _formKey.currentState!.validate();
  }

  void _setLoginFeedback(String? feedback) {
    _loginFeedback = feedback;
    notifyListeners();
  }

  void _setSignUpProgress(bool signUpProgress) {
    _signUpProgress = signUpProgress;
    notifyListeners();
  }
}
