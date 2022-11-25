import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/pages/auth/login_screen.dart';
import 'package:flutter_vietnam_app/pages/auth/signup_screen.dart';
import 'package:flutter_vietnam_app/pages/navigation_tab.dart';

class RoutePage {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => const NavigationTab(),
      '/log_in': (_) => const LoginScreen(),
      '/sign_up': (_) => const SignUpScreen()
    };
  }
}
