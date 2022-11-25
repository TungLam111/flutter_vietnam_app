import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vietnam_app/data/web_httpie/httpie.dart';
import 'package:flutter_vietnam_app/models/user.dart';
import 'package:http/http.dart';

abstract class AuthRepository {
  Future<void> signUpWithCredientials({
    required String username,
    required String name,
    required String password,
  });

  Future<void> loginWithCredentials({
    required String username,
    required String password,
  });

  Future<void> loginWithAuthToken(String authToken);

  Future<void> setAuthToken(String authToken);

  Future<UserModel> refreshUser();

  Future<UserModel> setUserWithData(String userData);

  void checkResponseIsOk(HttpieBaseResponse<Response> response);

  void checkResponseIsAccepted(HttpieBaseResponse<Response> response);

  void setLoggedInUser(UserModel user);

  void removeLoggedInUser();

  Future<void> storeAuthToken(String authToken);

  Future<String?> getStoredAuthToken();

  Future<void> removeStoredAuthToken();

  Future<void> storeUserData(String userData);

  Future<void> removeStoredUserData();

  String? getStoredUserData();

  UserModel makeLoggedInUser(String userData);

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
