
import 'dart:async';
import 'package:flutter_vietnam_app/services/storage/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SystemPreferencesStorage implements Store {

  Future<SharedPreferences> _sharedPreferencesCache;

  Future<SharedPreferences> _getSharedPreferences() async {
    if (_sharedPreferencesCache != null) return _sharedPreferencesCache;
    _sharedPreferencesCache = SharedPreferences.getInstance();
    return _sharedPreferencesCache;
  }

  Future<String> getValue(String key) async {
    SharedPreferences sharedPreferences = await _getSharedPreferences();
    return sharedPreferences.get(key);
  }

  Future<void> setValue(String key, dynamic value) async {
    SharedPreferences sharedPreferences = await _getSharedPreferences();
    return sharedPreferences.setString(key, value);
  }

  Future<void> remove(String key) async {
    SharedPreferences sharedPreferences = await _getSharedPreferences();
    return sharedPreferences.remove(key);
  }

  Future<void> clear() async {
    SharedPreferences preferences = await _getSharedPreferences();
    return Future.wait(preferences
        .getKeys()
        .map((key) => preferences.remove(key)));
  }
}