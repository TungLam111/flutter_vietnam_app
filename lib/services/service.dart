import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/item.dart';
import 'package:flutter_vietnam_app/models/user.dart';
import 'package:flutter_vietnam_app/services/auth/auth_service.dart';
import 'package:flutter_vietnam_app/services/categories.dart/categories_service.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

abstract class ServiceMain {
 
  Future<void> loginWithCredentials(
      {@required String username, @required String password});

  Future<void> loginWithAuthToken(String authToken) ;

  Future<void> signUpWithCredientials({@required String username, @required String email, @required String password});

  Future<void> setAuthToken(String authToken) ;

  Future<User> refreshUser();

  Future<User> setUserWithData(String userData) ;

  void checkResponseIsOk(HttpieBaseResponse response) ;

  void checkResponseIsAccepted(HttpieBaseResponse response);

  void setLoggedInUser(User user) ;

  void removeLoggedInUser();

  Future<void> storeAuthToken(String authToken);

  Future<String> getStoredAuthToken();

  Future<void> removeStoredAuthToken() ;

  Future<void> storeUserData(String userData) ;

  Future<void> removeStoredUserData() ;

  Future<String> getStoredUserData() ;

  User makeLoggedInUser(String userData);

  Future<List<Location>> getAllLocations();

  Future<Location> getLocationByName({@required String locationName});

  Future<List<Location>> getLocationsByList(List<String> listLocation);

   Future<List<Location>> getCategories() ;
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
