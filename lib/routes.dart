import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/pages/auth/login_screen.dart';
import 'package:flutter_vietnam_app/pages/auth/signup_screen.dart';
import 'package:flutter_vietnam_app/pages/home/home_page.dart';
class RoutePage {
    static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MyHomePage(),
      '/log_in': (_) => LoginScreen(),
      '/sign_up': (_) => SignUpScreen()
    };
  }
}