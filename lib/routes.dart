import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/pages/auth/login_screen.dart';
import 'package:flutter_vietnam_app/pages/auth/signup_screen.dart';

class RoutePage {
    static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/log_in': (_) => LoginScreen(),
      '/sign_up': (_) => SignUpScreen()
    };
  }
}