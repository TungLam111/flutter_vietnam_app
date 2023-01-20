
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vietnam_app/repository/auth_repo/auth_repo.dart';
import 'package:flutter_vietnam_app/services/auth/auth_service.dart';
import 'package:flutter_vietnam_app/utils/storage/storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._authApiService,
    this._storageService,
  );
  final AuthService _authApiService;
  final StorageService _storageService;

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
