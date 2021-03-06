
import 'package:flutter/cupertino.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';

abstract class Auth {
  Future<HttpieResponse> loginWithCredentials(
      {@required String username, @required String password});

  Future<HttpieResponse> getUserWithAuthToken(String authToken);
}