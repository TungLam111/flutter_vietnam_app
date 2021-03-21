import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/common/widgets/pages/page_item.dart';
import 'package:flutter_vietnam_app/pages/auth/login_screen.dart';
import 'package:flutter_vietnam_app/pages/auth/signup_screen.dart';
import 'package:flutter_vietnam_app/pages/description/struct_two.dart';
import 'package:flutter_vietnam_app/pages/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_vietnam_app/services/locator.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Color(0xff465EFD),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme:
            GoogleFonts.montserratTextTheme().apply(bodyColor: Colors.black87),
      ),
      debugShowCheckedModeBanner: false,

      home: Login(),
    );
  }
}
