import 'package:flutter/cupertino.dart';
import '../web_httpie/httpie.dart';

abstract class Auth {
Future<HttpieResponse> loginWithCredentials(
      {@required String username, @required String password});

  Future<HttpieResponse> getUserWithAuthToken(String authToken);
}