import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/common/widgets/pages/page_item.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_vietnam_app/pages/home/home_screen/home_screen.dart';
import 'package:flutter_vietnam_app/pages/home/home_screen/wall_screen.dart';

// 3 bottom bars
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  PageController _pageController;

  static List<Widget> _page = <Widget>[
    HomeScreen(),
    WallScreen(),
    DestinationDetail(),
    DestinationDetail(),
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox.expand(
              child: PageView(
              //  physics: BouncingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _selectedIndex = index);
                },
                children: <Widget>[
                  _page[0],
                  _page[1],
               //   _page[2],
               //   _page[3],
                ],
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
              ]),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: GNav(
                      rippleColor: Colors.grey[300],
                      hoverColor: Colors.grey[100],
                      gap: 20,
                      activeColor: Colors.black,
                      iconSize: 24,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      duration: Duration(milliseconds: 400),
                      tabBackgroundColor: Colors.grey[100],
                      tabs: [
                        //home - location
                        GButton(
                          
                          icon: LineIcons.home,
                          text: 'Home',
                        ),
                        //sharing corner
                        // GButton(
                        //   icon: LineIcons.heart,
                        //   text: 'Likes',
                        // ),
                        //destination
                        GButton(
                          icon: LineIcons.search,
                          text: 'Search',
                        ),
                        //personal + recommendation
                        // GButton(
                        //   icon: LineIcons.user,
                        //   text: 'Profile',
                        // ),
                      ],
                      selectedIndex: _selectedIndex,
                      onTabChange: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                        _pageController.animateToPage(
                          _selectedIndex,
                          duration: Duration(
                            milliseconds: 200,
                          ),
                          curve: Curves.easeIn,
                        );
                      }),
                ),
              ),
            )));
  }
}
