import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vietnam_app/data/web_httpie/httpie.dart';
import 'package:flutter_vietnam_app/models/user.dart';
import 'package:flutter_vietnam_app/repository/auth_repo/auth_repo.dart';
import 'package:flutter_vietnam_app/services/auth/auth_service.dart';
import 'package:flutter_vietnam_app/services/exception.dart';
import 'package:flutter_vietnam_app/utils/logg.dart';
import 'package:flutter_vietnam_app/utils/storage/storage_service.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._authApiService,
    this._storageService,
    this._httpieService,
  );
  final AuthService _authApiService;
  final StorageService _storageService;
  final Httpie _httpieService;

  UserModel? _loggedInUser;

  final ReplaySubject<UserModel?> _loggedInUserChangeSubject =
      ReplaySubject<UserModel?>(maxSize: 1);

  String? _authToken;

  @override
  Future<void> signUpWithCredientials({
    required String username,
    required String name,
    required String password,
  }) async {
    HttpieResponse response = await _authApiService.signupWithCredentials(
      name: name,
      username: username,
      password: password,
    );
    if (response.isOk() || response.isAccepted()) {
      Map<String, dynamic> parsedResponse = response.parseJsonBody();
      String message = parsedResponse['message'] as String;
      logg(message);
    } else if (response.isUnauthorized()) {
      throw const CredentialsMismatchError(
        'The provided credentials do not match.',
      );
    } else {
      throw HttpieRequestError<HttpieResponse>(response);
    }
  }

  @override
  Future<void> loginWithCredentials({
    required String username,
    required String password,
  }) async {
    HttpieResponse response = await _authApiService.loginWithCredentials(
      username: username,
      password: password,
    );
    if (response.isOk() || response.isAccepted()) {
      logg(response);
      Map<String, dynamic> parsedResponse = response.parseJsonBody();
      String authToken = parsedResponse['token'] as String;
      logg(authToken);
      await loginWithAuthToken(authToken);
    } else if (response.isUnauthorized()) {
      throw const CredentialsMismatchError(
        'The provided credentials do not match.',
      );
    } else {
      throw HttpieRequestError<HttpieResponse>(response);
    }
  }

  @override
  Future<void> loginWithAuthToken(String authToken) async {
    await setAuthToken(authToken);
    await refreshUser();
  }

  @override
  Future<void> setAuthToken(String authToken) async {
    _authToken = authToken;
    _httpieService.setAuthorizationToken(authToken);
    await storeAuthToken(authToken);
  }

  @override
  Future<UserModel> refreshUser() async {
    if (_authToken == null) throw const AuthTokenMissingError();

    HttpieResponse response =
        await _authApiService.getUserWithAuthToken(_authToken!);
    checkResponseIsOk(response);
    String userData = response.body;
    return setUserWithData(userData);
  }

  @override
  Future<UserModel> setUserWithData(String userData) async {
    UserModel user = makeLoggedInUser(userData);
    setLoggedInUser(user);
    await storeUserData(userData);
    return user;
  }

  @override
  void checkResponseIsOk(HttpieBaseResponse<Response> response) {
    if (response.isOk()) return;
    throw HttpieRequestError<HttpieBaseResponse<Response>>(response);
  }

  @override
  void checkResponseIsAccepted(HttpieBaseResponse<Response> response) {
    if (response.isAccepted()) return;
    throw HttpieRequestError<HttpieBaseResponse<Response>>(response);
  }

  @override
  void setLoggedInUser(UserModel user) {
    if (_loggedInUser == null || _loggedInUser?.id != user.id) {
      _loggedInUserChangeSubject.add(user);
    }
    _loggedInUser = user;
  }

  @override
  void removeLoggedInUser() {
    _loggedInUser = null;
    _loggedInUserChangeSubject.add(null);
  }

  @override
  Future<void> storeAuthToken(String authToken) {
    return _storageService.setAuthToken(authToken);
  }

  @override
  Future<String?> getStoredAuthToken() async {
    String? authToken = _storageService.getAuthToken();
    if (authToken != null) _authToken = authToken;
    return authToken;
  }

  @override
  Future<void> removeStoredAuthToken() async {
    _storageService.removeAuthToken();
  }

  @override
  Future<void> storeUserData(String userData) {
    return _storageService.storeUserData(userData);
  }

  @override
  Future<void> removeStoredUserData() async {
    _storageService.removeStoredUserData();
  }

  @override
  String? getStoredUserData() {
    return _storageService.getStoredUserData();
  }

  @override
  UserModel makeLoggedInUser(String userData) {
    return UserModel.fromJson(json.decode(userData) as Map<String, dynamic>);
  }

  @override
  Future<User?> getCurrentUserWithFirebase() {
    return _authApiService.getCurrentUserWithFirebase();
  }

  @override
  Future<User?> loginWithFirebase({
    required String emailId,
    required String password,
  }) async {
    return await _authApiService.loginWithFirebase(
      emailId: emailId,
      password: password,
    );
  }

  @override
  Future<User?> signupWithFirebase({
    required String emailId,
    required String password,
  }) async {
    return await _authApiService.signupWithFirebase(
      emailId: emailId,
      password: password,
    );
  }

  @override
  void setCurrentUser(User? user) {
    _storageService.setCurrentUser(user);
  }
}
