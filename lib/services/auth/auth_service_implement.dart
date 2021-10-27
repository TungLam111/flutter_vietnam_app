import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/services/data_repository/repository.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';

import '../locator.dart';
import '../web_httpie/httpie.dart';
import 'auth_service.dart';

class AuthApiService implements AuthService {
  static const String apiURL = 'https://shielded-depths-44788.herokuapp.com/';
  static const CHECK_USERNAME_PATH = 'api/auth/username-check/';
  static const CHECK_EMAIL_PATH = 'api/auth/email-check/';
  static const UPDATE_EMAIL_PATH = 'api/auth/user/settings/';
  static const VERIFY_EMAIL_TOKEN = 'api/auth/email/verify/';
  static const ACCEPT_GUIDELINES = 'api/auth/user/accept-guidelines/';
  static const SET_NEW_LANGUAGE = 'api/auth/user/languages/';
  static const GET_NEW_LANGUAGE = 'api/auth/user/languages/';
  static const UPDATE_PASSWORD_PATH = 'api/auth/user/settings/';
  static const CREATE_ACCOUNT_PATH = 'api/auth/register/';
  static const VERIFY_REGISTER_TOKEN = 'api/auth/register/verify-token/';
  static const DELETE_ACCOUNT_PATH = 'api/auth/user/delete/';
  static const GET_AUTHENTICATED_USER_PATH = 'api/auth/user/';
  static const UPDATE_AUTHENTICATED_USER_PATH = 'api/auth/user/';
  static const GET_USERS_PATH = 'api/auth/users/';
  static const LOGIN_PATH = 'auth/Login';
  static const SIGNUP_PATH = 'auth/Register';

  Httpie _httpService = serviceLocator<Httpie>();
  Repository _dataRepository = serviceLocator<Repository>();
  
  Future<FirebaseUser> loginWithFirebase({String emailId, String password}){
    return _dataRepository.loginWithFirebase(
              email: emailId, password: password);
  }

  Future<FirebaseUser> signupWithFirebase({String emailId, String password}){
    return _dataRepository.signupWithFirebase(
              email: emailId, password: password);
  }

  Future<FirebaseUser> getCurrentUserWithFirebase(){
    return _dataRepository.getCurrentUserWithFirebase();
  }

  Future<HttpieResponse> loginWithCredentials(
      {@required String username, @required String password}) {
    Map<String, dynamic> body = {'username': username, 'password': password};
    return this._httpService.postJSON('$apiURL$LOGIN_PATH', body: body);
  }

  Future<HttpieResponse> getUserWithAuthToken(String authToken) {
    Map<String, String> headers = {'Authorization': '$authToken'};

    return _httpService.get('$apiURL$GET_AUTHENTICATED_USER_PATH',
        headers: headers);
  }

  Future<HttpieResponse> signupWithCredentials(
      {@required String name,
      @required String username,
      @required String password}) {
    Map<String, dynamic> body = {
      "name": name,
      "username": username,
      "password": password
    };
    return _httpService.postJSON('$apiURL$SIGNUP_PATH', body: body);
  }
}
