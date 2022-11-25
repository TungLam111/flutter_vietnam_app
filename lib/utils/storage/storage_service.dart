import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class StorageService {
  User? getCurrentUser();

  void setCurrentUser(User? user);

  String? getValue(String key);

  Future<void> setValue(String key, dynamic value);

  Future<void> remove(String key);

  Future<void> clear();

  Future<bool> setAuthToken(dynamic value);

  String? getAuthToken();

  Future<bool> removeAuthToken();

  Future<void> storeUserData(String userData);

  Future<void> removeStoredUserData();

  String? getStoredUserData();

  Future<void> init();
}
