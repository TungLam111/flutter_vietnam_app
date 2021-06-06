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
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vietnam_app/services/fake_try/data_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vietnam_app/common/widgets/preferred_size_appbar.dart';
import 'package:flutter_vietnam_app/common/widgets/scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class HomeScreen extends StatefulWidget {

 @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  TextTheme textTheme;
  List<PopularTourModel> popularTourModels = new List();
  List<CountryModel> country = new List();
  final ServiceMain _userService = serviceLocator<ServiceMain>();
  File _image;
  String _error;
  final picker = ImagePicker();
  bool status = false;
  bool isReply = false;
  final DataRepository repository = DataRepository();
  TabController _tabController;
  final _auth = FirebaseAuth.instance;
  
  //pick image from camera
  Future getImage() async {
    String error;
    PickedFile pickedFile;
    try {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    } on PlatformException catch (e) {
      error = e.message;
    }
    if (!mounted) return;
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _cropImage();
      } else {
        _error = error;
      }
    });
  }

  Future getFromGallery() async {
    PickedFile pickedFile;
    String error;
    try {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    } on PlatformException catch (e) {
      error = e.message;
    }
    if (!mounted) return;

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _cropImage();
      });
    } else {
      _error = error;
    }
  }

  Future _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Extract an image',
            toolbarColor: Colors.deepPurple,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
      setState(() {
        if (croppedFile != null) 
          _image = croppedFile;
      });
  }

  void setStatus(bool statusLoading){
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
    _tabController = TabController(length: 6, vsync: this);
    getCurrentUser();
  }

  @override 
  Widget build(BuildContext context){
    textTheme = Theme.of(context).textTheme;
    return StreamBuilder<QuerySnapshot>(
      stream:  repository.getStreamSpeciality(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(
               child: CircularProgressIndicator(),
             );
        return OBCupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar : OBThemedNavigationBar( 
              middle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Text("I love banana",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 25))
              ],)
            ),
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
                labelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                labelColor: Colors.grey,
                onTap: (value) {
                   if (value == 0 ){

                  }
                  else if (value == 2) {
                  
                  }
                  else if (value == 3) {

                  }
                  else if (value == 1) {

                  }
                   else if (value == 4) {
                    
                  }
                   else if (value == 5) {
                    
                  }

                },
                tabs: [
                  Tab(
                    child: Text("All", style: TextStyle(fontSize: 13))
                  ),
                  Tab(
                    child: Text("Cuisine", style: TextStyle(fontSize: 13))
                  ),
                  Tab(
                    child: Text("Sightseeing", style: TextStyle(fontSize: 13))
                  ),
                  Tab(
                    child: Text("Culture", style: TextStyle(fontSize: 13))
                  ),
                  Tab(
                    child: Text("History", style: TextStyle(fontSize: 13))
                  ),
                  Tab( 
                    child: Text("Ethnicity", style: TextStyle(fontSize: 13))
                  )
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

                Container(),
                Container(),
                Container(),
                Container(),
                Container()
              ],
            ),
          ),
              ),
        //      const SizedBox(height: 30),
        //      const SizedBox(height: 30),
            ],),)

         ); });
  }

  Widget _buildList(BuildContext context,List<DocumentSnapshot> snapshotDataDocument ){

      return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            primary: false,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 4,
            itemCount: snapshotDataDocument.length,
            staggeredTileBuilder: (int index) =>
          new StaggeredTile.fit(2),
            itemBuilder: (context, index) => PlaceItem(location: Location.fromSnapshot(snapshotDataDocument[index])),
          ),
        );
  }
  
}

class PlaceItem extends StatelessWidget {
  final Location location;
  const PlaceItem({this.location});

  @override 
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
         Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DescriptionProduct(location: location,)),
  );
      },
      child:  Card(
      child:  Column(
        children: <Widget>[
           Stack(
            children: <Widget>[
              //new Center(child: new CircularProgressIndicator()),
               Center(
                child: CachedNetworkImage(
        imageUrl: location.images[0],
        progressIndicatorBuilder: (context, url, downloadProgress) => 
                CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
     ),
              ),
            ],
          ),
           Padding(
            padding: const EdgeInsets.all(4.0),
            child:  Column(
              children: <Widget>[
                 Text(
                  '${location.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                 Text(
                  location.origin,
                  style: const TextStyle(color: Colors.grey),
                ),
                 Text(
              location.description,
              maxLines: 2,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

