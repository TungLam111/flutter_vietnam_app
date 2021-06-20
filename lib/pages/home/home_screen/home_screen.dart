import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vietnam_app/common/widgets/pages/page_product.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter_vietnam_app/services/service.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vietnam_app/services/fake_try/data_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vietnam_app/common/widgets/preferred_size_appbar.dart';
import 'package:flutter_vietnam_app/common/widgets/scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'flip_card.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TextTheme textTheme;
  final ServiceMain _userService = serviceLocator<ServiceMain>();
  File _image;
  String _error;
  final picker = ImagePicker();
  bool status = false;
  bool isReply = false;
  final DataRepository repository = DataRepository();
  TabController _tabController;
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

  FlipDirection _direction;
  @override
  void initState() {
    super.initState();
    _direction = FlipDirection.VERTICAL;
    _tabController = TabController(length: 7, vsync: this);
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return StreamBuilder<QuerySnapshot>(
        stream: repository.getStreamSpeciality(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          return OBCupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              navigationBar: OBThemedNavigationBar(
                  middle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("I love banana",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25))
                ],
              )),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      child: TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        indicatorColor: Colors.grey,
                        labelStyle:
                            GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                        labelColor: Colors.grey,
                        tabs: [
                          Tab(
                              child:
                                  Text("All", style: TextStyle(fontSize: 13))),
                          Tab(
                              child: Text("Cuisine",
                                  style: TextStyle(fontSize: 13))),
                          Tab(
                              child: Text("Heritage",
                                  style: TextStyle(fontSize: 13))),
                          Tab(
                              child: Text("Sightseeing",
                                  style: TextStyle(fontSize: 13))),
                          Tab(
                              child: Text("Culture",
                                  style: TextStyle(fontSize: 13))),
                          Tab(
                              child: Text("History",
                                  style: TextStyle(fontSize: 13))),
                          Tab(
                              child: Text("Ethnicity",
                                  style: TextStyle(fontSize: 13)))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            _buildList(context, snapshot.data.documents),
                            _buildListCuisine(context),
                            _buildListHeritage(context),
                            _buildListSightseeing(context),
                            _buildListCulture(context),
                            _buildListHistory(context),
                            _buildListEthnicity(context),
                             
                          ],
                        ),
                      ),
                    ),
                    //      const SizedBox(height: 30),
                    //      const SizedBox(height: 30),
                  ],
                ),
              ));
        });
  }

  Widget _buildList(
      BuildContext context, List<DocumentSnapshot> snapshotDataDocument) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        primary: false,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        itemCount: snapshotDataDocument.length,
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        itemBuilder: (context, index) => PlaceItem(
            index: index,
            location: Location.fromSnapshot(snapshotDataDocument[index])),
      ),
    );
  }

  
  Widget _buildListHeritage(
      BuildContext context) {
      return  StreamBuilder<QuerySnapshot>(
      stream: repository.getStreamSpecialityByCategory("Heritage"),
      builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
    List<DocumentSnapshot> snapshotDataDocument = snapshot.data.documents;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        primary: false,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        itemCount: snapshotDataDocument.length,
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        itemBuilder: (context, index) => PlaceItem(
            index: index,
            location: Location.fromSnapshot(snapshotDataDocument[index])),
      ),
    );
      });
  }

  Widget _buildFlip() {
    return Column(
      children: [
        Container(
          width: 180,
          height: 180,
          margin: EdgeInsets.only(top: 20),
          child: FlipCard(
            speed: 3000,
            front: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blue.shade400,
                  ),
                ),
                Text(
                  'Front',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            back: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.orange.shade200,
                  ),
                ),
                Text(
                  'Back',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildListCuisine(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: repository.getStreamSpecialityByCategory("Food"),
      builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
    List<DocumentSnapshot> snapshotDataDocument = snapshot.data.documents;
        return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        primary: false,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        itemCount: snapshotDataDocument.length,
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        itemBuilder: (context, index) => PlaceItem(
            index: index,
            location: Location.fromSnapshot(snapshotDataDocument[index])),
      ),
        );
      }
    );
  }

  _buildListSightseeing(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: null,
      builder: (context, snapshot) {
        return Container(
          
        );
      }
    );
  }

  _buildListCulture(BuildContext context) {
        return StreamBuilder<QuerySnapshot>(
      stream: null,
      builder: (context, snapshot) {
        return Container();
      }
    );
  }

  _buildListHistory(BuildContext context) {
        return StreamBuilder<QuerySnapshot>(
      stream: null,
      builder: (context, snapshot) {
        return Container();
      }
    );
  }

  _buildListEthnicity(BuildContext context) {
        return StreamBuilder<QuerySnapshot>(
      stream: null,
      builder: (context, snapshot) {
        return Container();
      }
    );
  }

//     void callback() {
//     if (_direction == FlipDirection.VERTICAL) {
//       setState(() {
//         _direction = FlipDirection.HORIZONTAL;
//       });
//     } else {
//       setState(() {
//         _direction = FlipDirection.VERTICAL;
//       });
//     }
// }
}

class PlaceItem extends StatelessWidget {
  final Location location;
  final int index;
  const PlaceItem({this.index, this.location});

  @override
  Widget build(BuildContext context) {
    var rng = new Random();
    int random = 100 + rng.nextInt(100);
    int random2 = index % 8;
    return GestureDetector(
        onTap: () {
          //      print(location.location_id);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DescriptionProduct(
                      location: location,
                    )),
          );
        },
        child: Card(
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      //new Center(child: new CircularProgressIndicator()),
                      Row(
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: random.toDouble(),
                              imageUrl: location.images[0],
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      Center(
                                                                              child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: random.toDouble(),
                color: randomList[random2].withOpacity(0.9),
                width: 100,
                // padding: EdgeInsets.only(left: 15),
              ),
              Container(
                height: random.toDouble(),
                padding: const EdgeInsets.only(left: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text("${location.name}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

List<Color> randomList = [
  Colors.red,
  Colors.yellow,
  Colors.green[900],
  Colors.teal,
  Colors.purple,
  Colors.orange,
  Colors.blue,
  Colors.limeAccent
];
