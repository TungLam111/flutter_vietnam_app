
import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';

import '../locator.dart';
import '../web_httpie/httpie.dart';
import 'auth_service.dart';

class AuthApiService implements Auth {
  
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
  static const REQUEST_RESET_PASSWORD_PATH = 'api/auth/password/reset/';
  static const VERIFY_RESET_PASSWORD_PATH = 'api/auth/password/verify/';
  static const AUTHENTICATED_USER_NOTIFICATIONS_SETTINGS_PATH =
      'api/auth/user/notifications-settings/';

  Httpie _httpService = serviceLocator<Httpie>();


  Future<HttpieResponse> loginWithCredentials(
      {@required String username, @required String password}) {
Map<String, dynamic> body = {'username': username, 'password': password};
    return this._httpService.postJSON('$apiURL$LOGIN_PATH',
        body: body);
  }

    Future<HttpieResponse> getUserWithAuthToken(String authToken) {
    Map<String, String> headers = {'Authorization': '$authToken'};

    return _httpService.get('$apiURL$GET_AUTHENTICATED_USER_PATH',
        headers: headers);
  }

    Future<HttpieResponse> signupWithCredentials({@required String name, @required String username, @required String password}){
      Map<String, dynamic> body = {
        "name": name,
        "username": username,
        "password": password
      };
      return _httpService.postJSON('$apiURL$SIGNUP_PATH',
      body: body);
    }
}