import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vietnam_app/utils/storage/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServiceImpl implements StorageService {
  StorageServiceImpl();

  static const String storageKeyAuthToken = 'authToken';
  static const String storageKeyUserData = 'data';
  User? _user;

  SharedPreferences? _sharedPreferencesCache;

  @override
  void setCurrentUser(User? user) async {
    _user = user;
    String token = await user!.getIdToken();
    await setAuthToken(token);
  }

  @override
  Future<void> init() async {
    await _getSharedPreferences();
  }

  @override
  User? getCurrentUser() {
    return _user;
  }

  Future<SharedPreferences> _getSharedPreferences() async {
    if (_sharedPreferencesCache != null) return _sharedPreferencesCache!;
    _sharedPreferencesCache = await SharedPreferences.getInstance();
    return _sharedPreferencesCache!;
  }

  @override
  String? getValue(String key) {
    return _sharedPreferencesCache!.getString(key) ?? '';
  }

  @override
  Future<bool> setValue(String key, dynamic value) async {
    SharedPreferences sharedPreferences = await _getSharedPreferences();
    return sharedPreferences.setString(key, value.toString());
  }

  @override
  Future<bool> remove(String key) async {
    SharedPreferences sharedPreferences = await _getSharedPreferences();
    return await sharedPreferences.remove(key);
  }

  @override
  Future<List<bool>> clear() async {
    SharedPreferences preferences = await _getSharedPreferences();
    return Future.wait(
      preferences
          .getKeys()
          .map((String key) => preferences.remove(key))
          .toList(),
    );
  }

  @override
  Future<bool> setAuthToken(dynamic value) async {
    return await setValue(storageKeyAuthToken, value);
  }

  @override
  String? getAuthToken() {
    return getValue(storageKeyAuthToken);
  }

  @override
  Future<bool> removeAuthToken() async {
    return await remove(storageKeyAuthToken);
  }

  @override
  Future<void> storeUserData(String userData) {
    return setValue(storageKeyUserData, userData);
  }

  @override
  Future<void> removeStoredUserData() async {
    remove(storageKeyUserData);
  }

  @override
  String? getStoredUserData() {
    return getValue(storageKeyUserData);
  }
}
