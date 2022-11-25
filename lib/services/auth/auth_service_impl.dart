import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vietnam_app/data/firebase_api/firebase_api.dart';
import 'package:flutter_vietnam_app/data/web_httpie/httpie.dart';
import 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  AuthServiceImpl(this._httpService, this._firebaseApi);
  static const String apiURL = 'https://shielded-depths-44788.herokuapp.com/';
  static const String checkUsernamePath = 'api/auth/username-check/';
  static const String checkEmailPath = 'api/auth/email-check/';
  static const String updateEmailPath = 'api/auth/user/settings/';
  static const String verifyEmailTokenPath = 'api/auth/email/verify/';
  static const String acceptGuidelinesPath = 'api/auth/user/accept-guidelines/';
  static const String updatePasswordPath = 'api/auth/user/settings/';
  static const String createAccountPath = 'api/auth/register/';
  static const String verifyRegisterToken = 'api/auth/register/verify-token/';
  static const String deleteAccountPath = 'api/auth/user/delete/';
  static const String getAuthenticatedUserPath = 'api/auth/user/';
  static const String updateAuthenticatedUserPath = 'api/auth/user/';
  static const String getUSersPath = 'api/auth/users/';
  static const String loginPath = 'auth/Login';
  static const String signupPath = 'auth/Register';

  final Httpie _httpService;
  final FirebaseApi _firebaseApi;

  @override
  Future<User?> loginWithFirebase({
    required String emailId,
    required String password,
  }) async {
    return await _firebaseApi.loginWithFirebase(
      email: emailId,
      password: password,
    );
  }

  @override
  Future<User?> signupWithFirebase({
    required String emailId,
    required String password,
  }) {
    return _firebaseApi.signupWithFirebase(email: emailId, password: password);
  }

  @override
  Future<User?> getCurrentUserWithFirebase() {
    return _firebaseApi.getCurrentUserWithFirebase();
  }

  @override
  Future<HttpieResponse> loginWithCredentials({
    required String username,
    required String password,
  }) {
    Map<String, dynamic> body = <String, dynamic>{
      'username': username,
      'password': password
    };
    return _httpService.postJSON('$apiURL$loginPath', body: body);
  }

  @override
  Future<HttpieResponse> getUserWithAuthToken(String authToken) {
    Map<String, String> headers = <String, String>{'Authorization': authToken};

    return _httpService.get(
      '$apiURL$getAuthenticatedUserPath',
      headers: headers,
    );
  }

  @override
  Future<HttpieResponse> signupWithCredentials({
    required String name,
    required String username,
    required String password,
  }) {
    Map<String, dynamic> body = <String, dynamic>{
      'name': name,
      'username': username,
      'password': password
    };
    return _httpService.postJSON('$apiURL$signupPath', body: body);
  }
}
