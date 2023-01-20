import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vietnam_app/data/firebase_api/firebase_api.dart';
import 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  AuthServiceImpl(this._firebaseApi);

  final FirebaseApi _firebaseApi;

  @override
  Future<User?> loginWithFirebase({
    required String emailId,
    required String password,
  }) async {
    return await _firebaseApi.loginWithFirebase(
      email: emailId,
      password: password,
    );
  }

  @override
  Future<User?> signupWithFirebase({
    required String emailId,
    required String password,
  }) {
    return _firebaseApi.signupWithFirebase(email: emailId, password: password);
  }

  @override
  Future<User?> getCurrentUserWithFirebase() {
    return _firebaseApi.getCurrentUserWithFirebase();
  }
}
