import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/pages/auth/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
//import 'package:flutter_vietnam_app/services/fake_try/homelist.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized(); //you may need this line 
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
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