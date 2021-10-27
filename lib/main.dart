import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized(); 
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Vietnam App',
      theme: ThemeData(
        accentColor: Color(0xff465EFD),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme:
            GoogleFonts.montserratTextTheme().apply(bodyColor: Colors.black87),
      ),
      debugShowCheckedModeBanner: false,

      initialRoute: "/log_in",
      routes: RoutePage.getRoute(),
    );
  }
}