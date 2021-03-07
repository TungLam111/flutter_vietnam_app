import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/user.dart';
import 'package:flutter_vietnam_app/services/auth/auth_service.dart';
import 'package:flutter_vietnam_app/services/categories.dart/categories_service.dart';
import 'package:flutter_vietnam_app/services/service.dart';
import 'package:flutter_vietnam_app/services/storage/storage_service.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';
import 'locator.dart';
import 'web_httpie/httpie.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class Service implements ServiceMain {
  final Store  _userStorage = serviceLocator<Store>();
  final Auth _authApiService = serviceLocator<Auth>();
  final Httpie _httpieService = serviceLocator<Httpie>();

  var _loggedInUser;
  
  final _loggedInUserChangeSubject = ReplaySubject<User>(maxSize: 1);
  static const STORAGE_KEY_AUTH_TOKEN = 'authToken';
  static const STORAGE_KEY_USER_DATA = 'data';

  String _authToken; 

  Future<void> loginWithCredentials(
      {@required String username, @required String password}) async {
        print("HOHO");
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
    await setAuthToken(authToken);
    print("lololo");
    await refreshUser();
  //  print("momo");
  }

  Future<void> setAuthToken(String authToken) async {
    _authToken = authToken;
    _httpieService.setAuthorizationToken(authToken);
    await storeAuthToken(authToken);
  }

  Future<User> refreshUser() async {
    if (_authToken == null) throw AuthTokenMissingError();

    HttpieResponse response =
        await _authApiService.getUserWithAuthToken(_authToken);
  checkResponseIsOk(response);
    var userData = response.body;
    return setUserWithData(userData);
  }

  Future<User> setUserWithData(String userData) async {
    var user = makeLoggedInUser(userData);
    setLoggedInUser(user);
    await storeUserData(userData);
    return user;
  }

  void checkResponseIsOk(HttpieBaseResponse response) {
    if (response.isOk()) return;
    throw HttpieRequestError(response);
  }

  void checkResponseIsAccepted(HttpieBaseResponse response) {
    if (response.isAccepted()) return;
    throw HttpieRequestError(response);
  }

  void setLoggedInUser(User user) {
    if (_loggedInUser == null || _loggedInUser.id != user.id)
      _loggedInUserChangeSubject.add(user);
    _loggedInUser = user;
  }

  void removeLoggedInUser() {
    _loggedInUser = null;
    _loggedInUserChangeSubject.add(null);
  }

  Future<void> storeAuthToken(String authToken) {
    return _userStorage.setValue(STORAGE_KEY_AUTH_TOKEN, authToken);
  }

  Future<String> getStoredAuthToken() async {
    String authToken = await _userStorage.getValue(STORAGE_KEY_AUTH_TOKEN);
    if (authToken != null) _authToken = authToken;
    return authToken;
  }

  Future<void> removeStoredAuthToken() async {
    _userStorage.remove(STORAGE_KEY_AUTH_TOKEN);
  }

  Future<void> storeUserData(String userData) {
    return _userStorage.setValue(STORAGE_KEY_USER_DATA, userData);
  }

  Future<void> removeStoredUserData() async {
    _userStorage.remove(STORAGE_KEY_USER_DATA);
  }

  Future<String> getStoredUserData() async {
    return _userStorage.getValue(STORAGE_KEY_USER_DATA);
  }

  User makeLoggedInUser(String userData) {
    return User.fromJson(json.decode(userData), storeInSessionCache: true);
  }
}