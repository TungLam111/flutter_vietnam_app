import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/routes.dart';
import 'package:flutter_vietnam_app/utils/storage/storage_service.dart';
import 'package:flutter_vietnam_app/view_models/home_notifier.dart';
import 'package:flutter_vietnam_app/view_models/login_notifier.dart';
import 'package:flutter_vietnam_app/view_models/navigation_tab_notifier.dart';
import 'package:flutter_vietnam_app/view_models/search_notifier.dart';
import 'package:flutter_vietnam_app/view_models/signup_notifier.dart';
import 'package:flutter_vietnam_app/view_models/wall_notifier.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_vietnam_app/services/locator.dart' as locator;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await locator.setupServiceLocator();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: <SystemUiOverlay>[SystemUiOverlay.bottom],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<LoginScreenViewModel>(
          create: (_) => locator.serviceLocator<LoginScreenViewModel>(),
        ),
        ChangeNotifierProvider<SignupScreenViewModel>(
          create: (_) => locator.serviceLocator<SignupScreenViewModel>(),
        ),
        ChangeNotifierProvider<NavigationTabViewModel>(
          create: (_) => locator.serviceLocator<NavigationTabViewModel>(),
        ),
        ChangeNotifierProvider<HomePageViewModel>(
          create: (_) => locator.serviceLocator<HomePageViewModel>(),
        ),
        ChangeNotifierProvider<SearchViewModel>(
          create: (_) => locator.serviceLocator<SearchViewModel>(),
        ),
        ChangeNotifierProvider<WallPageViewModel>(
          create: (_) => locator.serviceLocator<WallPageViewModel>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Vietnam App',
        theme: ThemeData(
          primaryColor: const Color(0xff465EFD),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.montserratTextTheme()
              .apply(bodyColor: Colors.black87),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: locator
                    .serviceLocator<StorageService>()
                    .getAuthToken()
                    ?.isNotEmpty ==
                true
            ? '/'
            : '/log_in',
        routes: RoutePage.getRoute(),
      ),
    );
  }
}
