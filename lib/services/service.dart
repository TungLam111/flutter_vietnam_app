import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/user.dart';
import 'package:flutter_vietnam_app/services/auth_service.dart';
import 'package:flutter_vietnam_app/services/categories_service.dart';
import 'package:flutter_vietnam_app/services/service_locator.dart';
import 'httpie.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class Service {
  OBStorage _userStorage;
  final _loggedInUserChangeSubject = ReplaySubject<User>(maxSize: 1);
  static const STORAGE_KEY_AUTH_TOKEN = 'authToken';
  static const STORAGE_KEY_USER_DATA = 'data';

  AuthApiService _authApiService;
  User _loggedInUser;
  HttpieService _httpieService;
  CategoriesApiService _categoriesApiService;
  String _authToken;

  Service(this._httpieService, this._userStorage, this._authApiService, this._categoriesApiService);

  factory Service.create(){
    return Service(HttpieService(), OBStorage().getSystemPreferencesStorage() , AuthApiService.create(), CategoriesApiService.create());
  }

  void createCategorieService(CategoriesApiService categoriesApiService){
    _categoriesApiService = categoriesApiService;
  }

  Future<void> loginWithCredentials(
      {@required String username, @required String password}) async {
    HttpieResponse response = await _authApiService.loginWithCredentials(
        username: username, password: password);
    if (response.isOk()) {
      var parsedResponse = response.parseJsonBody();
      var authToken = parsedResponse['token'];
      print(authToken);
      await loginWithAuthToken(authToken);
    } else if (response.isUnauthorized()) {
      throw CredentialsMismatchError('The provided credentials do not match.');
    } else {
      throw HttpieRequestError(response);
    }
  }

  Future<void> loginWithAuthToken(String authToken) async {
    await _setAuthToken(authToken);
    print("lololo");
  //  await refreshUser();
  //  print("momo");
  }

  Future<void> _setAuthToken(String authToken) async {
    _authToken = authToken;
    _httpieService.setAuthorizationToken(authToken);
    await _storeAuthToken(authToken);
  }

  Future<User> refreshUser() async {
    if (_authToken == null) throw AuthTokenMissingError();

    HttpieResponse response =
        await _authApiService.getUserWithAuthToken(_authToken);
    _checkResponseIsOk(response);
    var userData = response.body;
    return _setUserWithData(userData);
  }

  Future<User> _setUserWithData(String userData) async {
    var user = _makeLoggedInUser(userData);
    _setLoggedInUser(user);
    await _storeUserData(userData);
    return user;
  }

  void _checkResponseIsOk(HttpieBaseResponse response) {
    if (response.isOk()) return;
    throw HttpieRequestError(response);
  }

  void _checkResponseIsAccepted(HttpieBaseResponse response) {
    if (response.isAccepted()) return;
    throw HttpieRequestError(response);
  }

  void _setLoggedInUser(User user) {
    if (_loggedInUser == null || _loggedInUser.id != user.id)
      _loggedInUserChangeSubject.add(user);
    _loggedInUser = user;
  }

  void _removeLoggedInUser() {
    _loggedInUser = null;
    _loggedInUserChangeSubject.add(null);
  }

  Future<void> _storeAuthToken(String authToken) {
    return _userStorage.set(STORAGE_KEY_AUTH_TOKEN, authToken);
  }

  Future<String> _getStoredAuthToken() async {
    String authToken = await _userStorage.get(STORAGE_KEY_AUTH_TOKEN);
    if (authToken != null) _authToken = authToken;
    return authToken;
  }

  Future<void> _removeStoredAuthToken() async {
    _userStorage.remove(STORAGE_KEY_AUTH_TOKEN);
  }

  Future<void> _storeUserData(String userData) {
    return _userStorage.set(STORAGE_KEY_USER_DATA, userData);
  }

  Future<void> _removeStoredUserData() async {
    _userStorage.remove(STORAGE_KEY_USER_DATA);
  }

  Future<String> _getStoredUserData() async {
    return _userStorage.get(STORAGE_KEY_USER_DATA);
  }

  User _makeLoggedInUser(String userData) {
    return User.fromJson(json.decode(userData), storeInSessionCache: true);
  }
}

class CredentialsMismatchError implements Exception {
  final String msg;

  const CredentialsMismatchError(this.msg);

  String toString() => 'CredentialsMismatchError: $msg';
}

class AuthTokenMissingError implements Exception {
  const AuthTokenMissingError();

  String toString() => 'AuthTokenMissingError: No auth token was found.';
}

class NotLoggedInUserError implements Exception {
  const NotLoggedInUserError();

  String toString() => 'NotLoggedInUserError: No user is logged in.';
}
