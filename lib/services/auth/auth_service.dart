import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<User?> getCurrentUserWithFirebase();

  Future<User?> loginWithFirebase({
    required String emailId,
    required String password,
  });

  Future<User?> signupWithFirebase({
    required String emailId,
    required String password,
  });
}
