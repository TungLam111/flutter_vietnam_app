import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/common/widgets/pages/page_item.dart';
import 'package:flutter_vietnam_app/common/widgets/pages/page_product.dart';
import 'package:flutter_vietnam_app/pages/auth/page_view.dart';
import 'package:flutter_vietnam_app/pages/description/struct_two.dart';
import 'package:flutter_vietnam_app/pages/home/home_screen/chat/chat_screen.dart';
import 'package:flutter_vietnam_app/pages/home/recommendation_screen/recommendation_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'home_screen/chat/chat_room.dart';
import 'home_screen/home_screen.dart';
import 'home_screen/subpages/search_screen.dart';
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
    SearchScreen(),
    DestinationDetail(),
    StructTwo(),
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
                  _page[2],
                  _page[3],
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
                      gap: 8,
                      activeColor: Colors.black,
                      iconSize: 24,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      duration: Duration(milliseconds: 400),
                      tabBackgroundColor: Colors.grey[100],
                      tabs: [
                        GButton(
                          icon: LineIcons.home,
                          text: 'Home',
                        ),
                        GButton(
                          icon: LineIcons.heart,
                          text: 'Likes',
                        ),
                        GButton(
                          icon: LineIcons.search,
                          text: 'Search',
                        ),
                        GButton(
                          icon: LineIcons.user,
                          text: 'Profile',
                        ),
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
