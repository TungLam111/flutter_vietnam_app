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
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

/// Creates [YoutubePlayerDemoApp] widget.
// class YoutubePlayerDemoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Youtube Player Flutter',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         appBarTheme: const AppBarTheme(
//           color: Colors.blueAccent,
//           textTheme: TextTheme(
//             headline6: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w300,
//               fontSize: 20.0,
//             ),
//           ),
//         ),
//         iconTheme: const IconThemeData(
//           color: Colors.blueAccent,
//         ),
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

/// Homepage