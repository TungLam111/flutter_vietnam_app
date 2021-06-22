import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter_vietnam_app/services/service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_vietnam_app/services/fake_try/data_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vietnam_app/common/widgets/preferred_size_appbar.dart';
import 'package:flutter_vietnam_app/common/widgets/scaffold.dart';
import 'package:flutter_vietnam_app/pages/home/home_screen/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'no_result.dart';
import 'search_page.dart';
import 'post_item.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
final DataRepository repository = DataRepository();

class WallScreen extends StatefulWidget {
  @override
  _WallScreenState createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  TextTheme textTheme;
  final ServiceMain _userService = serviceLocator<ServiceMain>();
  final picker = ImagePicker();
  bool status = false;
  bool isReply = false;
  bool _isOpen;
  //final DataRepository repository = DataRepository();
  final _auth = FirebaseAuth.instance;

  String _currentFilter;

  void setStatus(bool statusLoading) {
    setState(() {
      status = statusLoading;
    });
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _isOpen = false;
    _currentFilter = "All";
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return StreamBuilder<QuerySnapshot>(
        stream: _currentFilter != "All"
            ? repository.getStreamPostFilter(_currentFilter)
            : repository.getStreamPost(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          List<DocumentSnapshot> data = snapshot.data.documents;
          return OBCupertinoPageScaffold(
              backgroundColor: Colors.black,
              resizeToAvoidBottomInset: true,
              navigationBar: OBThemedNavigationBar(
                  bgColor: Colors.black,
                  middle: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("I love banana",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25)),
                        GestureDetector(
                            onTap: () => _navigateToSearch(context),
                            child: Icon(Icons.search, color: Colors.white))
                      ],
                    ),
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 70),
                          Container(
                              child: (data == null || data.length == 0)
                                  ? _buildNoList(context)
                                  : _buildList(context, data)),
                        ],
                      ),
                      Stack(
                        children: [
                          Column(
                            children: [
                              AnimatedContainer(
                                  height: _isOpen ? 250 : 0,
                                  margin: EdgeInsets.only(top: 30.0),
                                  padding: EdgeInsets.only(top: 40),
                                  curve: Curves.easeInOutCubic,
                                  width: MediaQuery.of(context).size.width - 30,
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )),
                                  child: ListView(
                                    children: [
                                      "All",
                                      "Culture",
                                      "Tradition",
                                      "History",
                                      "Ethnicity",
                                      "SaiGon",
                                      "HaNoi",
                                      "Heritage",
                                      "VietNam wars",
                                      "Humanity"
                                    ].map((e) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _currentFilter = e;
                                            _isOpen = !_isOpen;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: 10, left: 10, right: 10),
                                          child: Text(e,
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          padding: EdgeInsets.only(
                                              top: 20, bottom: 20, left: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                  )),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isOpen = !_isOpen;
                              });
                            },
                            child: Container(
                                height: 60,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 60,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Category filtering: $_currentFilter",
                                            ),
                                            RotateIcon(
                                                close: _isOpen,
                                                color: Colors.black)
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> data) {
    return AnimationLimiter(
        child: ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(),
      shrinkWrap: true,
      primary: false,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                    child: PostItem(post: Post.fromSnapshot(data[index])))));
      },
    ));
  }

  Widget _buildNoList(BuildContext context) {
    return NoResultFoundScreen();
  }
}

void _navigateToSearch(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SearchPage()),
  );
}
