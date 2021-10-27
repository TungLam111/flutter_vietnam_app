
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';

abstract class AuthService {
  Future<FirebaseUser> getCurrentUserWithFirebase();

  Future<FirebaseUser> loginWithFirebase({String emailId, String password});
  
  Future<FirebaseUser> signupWithFirebase({String emailId, String password});

  Future<HttpieResponse> loginWithCredentials(
      {@required String username, @required String password});

  Future<HttpieResponse> getUserWithAuthToken(String authToken);

  Future<HttpieResponse> signupWithCredentials({@required String name, @required String username, @required String password});
}