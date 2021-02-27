import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'storage_service_implement.dart';

class OBStorage {
  Store store;
  String namespace;

  OBStorage({this.store, this.namespace});

  OBStorage getSecureStorage({String namespace}) {
    return OBStorage(store: _SecureStore(), namespace: namespace);
  }

  OBStorage getSystemPreferencesStorage({String namespace}) {
    return OBStorage(
        store: _SystemPreferencesStorage(namespace), namespace: namespace);
  }

  Future<String> get(String key, {String defaultValue}) async {
    String finalKey = _makeKey(key);
    String value = await this.store.get(finalKey);
    if (value == null && defaultValue != null) {
      await store.set(finalKey, defaultValue);
      value = defaultValue;
    }

    return value;
  }

  Future<void> set(String key, dynamic value) {
    print(key);
    print(value);
    return this.store.set(_makeKey(key), value);
  }

  Future<void> remove(String key) {
    return this.store.remove(this._makeKey(key));
  }

  Future<void> clear() {
    return this.store.clear();
  }

  String _makeKey(String key) {
    if (this.namespace == null) return key;
    return '$namespace.$key';
  }
}

class _SecureStore implements Store<String> {
  final storage = new FlutterSecureStorage();
  Set<String> _storedKeys = Set();

  // Clears the whole storage, including other namespaces.
  Future clearAll(){
    return storage.deleteAll();
  }

  _SecureStore() {
    _loadPreviouslyStoredKeys();
  }

  void _loadPreviouslyStoredKeys() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> storedKeys = preferences.getStringList('secure_store.keylist');
    if(storedKeys != null && storedKeys.isNotEmpty)  _storedKeys.addAll(storedKeys);
  }

  void _saveStoredKeys() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList('secure_store.keylist', _storedKeys.toList());
  }

  Future<String> get(String key) async {
    try {
      return storage.read(key: key);
    } on PlatformException {
      // This might happen when failed to decrypt, in that case the whole storage is useless. Clear it.
      await clearAll();
      return null;
    }
  }

  Future<void> set(String key, String value) {
    if (_storedKeys.add(key)) {
      _saveStoredKeys();
    }
    return storage.write(key: key, value: value);
  }

  Future<void> remove(String key) {
    if (_storedKeys.remove(key)) {
      _saveStoredKeys();
    }
    return storage.delete(key: key);
  }

  Future<void> clear() {
    return Future.wait(
        _storedKeys.map((String key) => storage.delete(key: key)));
  }
}

class _SystemPreferencesStorage implements Store<String> {
  final String _namespace;

  Future<SharedPreferences> _sharedPreferencesCache;

  _SystemPreferencesStorage(String namespace) : _namespace = namespace;

  Future<SharedPreferences> _getSharedPreferences() async {
    if (_sharedPreferencesCache != null) return _sharedPreferencesCache;
    _sharedPreferencesCache = SharedPreferences.getInstance();
    return _sharedPreferencesCache;
  }

  Future<String> get(String key) async {
    SharedPreferences sharedPreferences = await _getSharedPreferences();
    return sharedPreferences.get(key);
  }

  Future<void> set(String key, String value) async {
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
        .where((key) => key.startsWith('$_namespace.'))
        .map((key) => preferences.remove(key)));
  }
}