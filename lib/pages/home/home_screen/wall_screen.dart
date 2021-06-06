import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter_vietnam_app/services/service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_vietnam_app/services/fake_try/data_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vietnam_app/common/widgets/preferred_size_appbar.dart';
import 'package:flutter_vietnam_app/common/widgets/scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_vietnam_app/pages/home/home_screen/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter_vietnam_app/pages/home/home_screen/post_page.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
final DataRepository repository = DataRepository();

class WallScreen extends StatefulWidget {
  @override
  _WallScreenState createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  TextTheme textTheme;
  List<PopularTourModel> popularTourModels = new List();
  List<CountryModel> country = new List();
  final ServiceMain _userService = serviceLocator<ServiceMain>();
  File _image;
  String _error;
  final picker = ImagePicker();
  bool status = false;
  bool isReply = false;
  bool _isOpen;
  //final DataRepository repository = DataRepository();
  final _auth = FirebaseAuth.instance;

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
    country = getCountrys();
    popularTourModels = getPopularTours();
    _isOpen = false;
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return StreamBuilder<QuerySnapshot>(
        stream: repository.getStreamPost(),
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
                  middle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("I love banana",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25))
                    ],
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
                          Container(child: _buildList(context, data)),
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
                                      "Culture",
                                      "Tradition",
                                      "History",
                                      "Ethnicity",
                                      "SaiGon",
                                      "HaNoi",
                                      "VietNam wars"
                                    ].map((e) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            bottom: 10, left: 10, right: 10),
                                        child: Text(e,
                                            style:
                                                TextStyle(color: Colors.white)),
                                        padding: EdgeInsets.only(
                                            top: 20, bottom: 20, left: 10),
                                        decoration:
                                            BoxDecoration(color: Colors.black),
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
                                              "Category filtering",
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
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(),
      shrinkWrap: true,
      primary: false,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return PostItem(post: Post.fromSnapshot(data[index]));
      },
    );
  }
}

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({this.post});

  @override
  Widget build(BuildContext context) {
    final DataRepository repository = DataRepository();
    //  var data = _firestore.collection("users").where('email', isEqualTo: post.poster );
    return StreamBuilder<QuerySnapshot>(
        stream: repository.getStreamUser(post.poster),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          List<DocumentSnapshot> users = snapshot.data.documents;
          DocumentSnapshot user = users[0];

          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostPage(post: post)),
                );
                // _firestore.collection("users").document(loggedInUser.uid).setData({"displayName": "tunglamahihi", "phoneNumber": "0829976232", "photoUrl": "https://cdn.ibispaint.com/movie/728/965/728965653/image728965653.png"});
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          user["photoUrl"].toString())),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    width: 150,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${post.category}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text("@${user["displayName"]}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(post.postTime),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image.network(
                            "${post.images[0]}",
                            fit: BoxFit.fitWidth,
                            width: 400,
                            height: 200,
                          ),
                          Text("${post.title}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25)),
                          Wrap(
                            children: post.tags.map((e) {
                              return Container(
                                child: Text("#${e.toString()}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic)),
                                decoration:
                                    BoxDecoration(color: Colors.blueGrey),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                margin: EdgeInsets.only(left: 10, bottom: 5),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
