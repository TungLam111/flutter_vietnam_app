import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vietnam_app/data/web_httpie/httpie.dart';

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

  Future<HttpieResponse> loginWithCredentials({
    required String username,
    required String password,
  });

  Future<HttpieResponse> getUserWithAuthToken(String authToken);

  Future<HttpieResponse> signupWithCredentials({
    required String name,
    required String username,
    required String password,
  });
}
