import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  // Firebase
  Future<User?> loginWithFirebase({
    required String emailId,
    required String password,
  });

  Future<User?> getCurrentUserWithFirebase();

  Future<User?> signupWithFirebase({
    required String emailId,
    required String password,
  });

  void setCurrentUser(User? user);
}
