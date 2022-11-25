import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/enum.dart';
import 'package:flutter_vietnam_app/pages/home/home_screen.dart';
import 'package:flutter_vietnam_app/pages/home/wall_screen.dart';
import 'package:flutter_vietnam_app/view_models/navigation_tab_notifier.dart';
import 'package:provider/provider.dart';

class NavigationTab extends StatefulWidget {
  const NavigationTab({Key? key}) : super(key: key);

  @override
  State<NavigationTab> createState() => _NavigationTabState();
}

class _NavigationTabState extends State<NavigationTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<NavigationTabViewModel>(
        builder: (
          BuildContext context,
          NavigationTabViewModel value,
          Widget? child,
        ) {
          return Scaffold(
            body: SizedBox.expand(
              child: value.state == GeneralContentType.tab1
                  ? const HomeScreen()
                  : const WallScreen(),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
                ],
              ),
              child: SafeArea(
                child: Container(
                  color: Colors.blueGrey,

                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            value.setState(GeneralContentType.tab1);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 15,
                            ),
                            child: Text(
                              'Location',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            value.setState(GeneralContentType.tab2);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 15,
                            ),
                            child: Text(
                              'Feed',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ), // navigation bar here !!!
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
