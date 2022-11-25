import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/common/widgets/preferred_size_appbar.dart';
import 'package:flutter_vietnam_app/common/widgets/scaffold.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vietnam_app/pages/home/widget/no_result.dart';
import 'package:flutter_vietnam_app/pages/home/search_page.dart';
import 'package:flutter_vietnam_app/pages/home/widget/post_item.dart';
import 'package:flutter_vietnam_app/pages/home/widgets.dart';
import 'package:flutter_vietnam_app/view_models/wall_notifier.dart';
import 'package:provider/provider.dart';

class WallScreen extends StatefulWidget {
  const WallScreen({Key? key}) : super(key: key);

  @override
  State<WallScreen> createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WallPageViewModel>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return OBCupertinoPageScaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      navigationBar: OBThemedNavigationBar(
        bgColor: Colors.black,
        middle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'I love banana',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              GestureDetector(
                onTap: () => _navigateToSearch(context),
                child: const Icon(Icons.search, color: Colors.white),
              )
            ],
          ),
        ),
      ),
      child: Consumer<WallPageViewModel>(
        builder:
            (BuildContext context, WallPageViewModel value, Widget? child) {
          if (value.listPost == null || value.listPost!.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 70),
                      Container(
                        child: (value.listPost?.isNotEmpty == true)
                            ? _buildList(context, value.listPost!)
                            : _buildNoList(context),
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          AnimatedContainer(
                            height: value.isOpen ? 250 : 0,
                            margin: const EdgeInsets.only(top: 30.0),
                            padding: const EdgeInsets.only(top: 40),
                            curve: Curves.easeInOutCubic,
                            width: MediaQuery.of(context).size.width - 30,
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: ListView(
                              children: <String>[
                                'All',
                                'Culture',
                                'Tradition',
                                'History',
                                'Ethnicity',
                                'SaiGon',
                                'HaNoi',
                                'Heritage',
                                'VietNam wars',
                                'Humanity'
                              ].map((String e) {
                                return GestureDetector(
                                  onTap: () {
                                    value.setNewFilter(e);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 10,
                                      left: 10,
                                      right: 10,
                                    ),
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 20,
                                      left: 10,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                    ),
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          value.setIsOpen();
                        },
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 60,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '''Category filtering: ${value.currentFilter}''',
                                      ),
                                      RotateIcon(
                                        close: value.isOpen,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Post> data) {
    return AnimationLimiter(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        shrinkWrap: true,
        primary: false,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: PostItem(post: data[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoList(BuildContext context) {
    return const NoResultFoundScreen();
  }
}

void _navigateToSearch(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => const SearchPage(),
    ),
  );
}
