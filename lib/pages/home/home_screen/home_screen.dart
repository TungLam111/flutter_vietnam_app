import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vietnam_app/common/widgets/pages/page_product.dart';
import 'package:flutter_vietnam_app/models/item.dart';
import 'package:flutter_vietnam_app/common/widgets/scroll_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_vietnam_app/common/widgets/pages/page_tour.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter_vietnam_app/services/service.dart';
import 'package:flutter_vietnam_app/services/service_impl.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {

 @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextTheme textTheme;
  List<PopularTourModel> popularTourModels = new List();
  List<CountryModel> country = new List();
  List<Location> placeList = [];
  final ServiceMain _userService = serviceLocator<ServiceMain>();
  File _image;
  String _error;
  final picker = ImagePicker();
  bool status = false;
  bool isReply = false;
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

  Future<Null> _cropImage() async {
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
  
  void getLocations() async {
    setStatus(false);
     List<Location> temp = await _userService.getAllLocations();
     setState((){
       placeList = temp;
       print(temp[2].name);
     });
     setStatus(true);
     print("huhu");
  }

  void setStatus(bool sta){
    setState(() {
      status = sta;
    });
  }
  @override
  void initState() {
    super.initState();
    country = getCountrys();
    popularTourModels = getPopularTours();
    getLocations();
  }
  @override 
  Widget build(BuildContext context){
    textTheme = Theme.of(context).textTheme;
    
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar : AppBar(
          title: Center(child: Text("VietTravel", style: textTheme.headline6
              .copyWith(fontWeight: FontWeight.bold, color: Color(0xff139157)),)),
          backgroundColor: Colors.white,
          leading: GestureDetector(child: Icon(Icons.menu, color: Color(0xff139157)),
          onTap: (){
          }),
          actions: [
           const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Icon(Icons.settings, color:Color(0xff139157)))
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
          const SizedBox(height: 30),
          _buildHeader(),
          const SizedBox(height: 30),
          _buildSearchs(),
          const Text("Current search"),

          const SizedBox(height: 30),
          const Text("Popular crossy tours"),
          const Text("Tours in region"),
           Container(
                height: 240,
                child: ListView.builder(
                    
                    itemCount: country.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CountryListTile(
                        label: country[index].label,
                        countryName: country[index].countryName,
                        noOfTours: country[index].noOfTours,
                        rating: country[index].rating,
                        imgUrl: country[index].imgUrl,
                      );
                    }),
              ),
          const SizedBox(height: 30),
          const Text("Popular tours"),
           Container(
             child:   ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: popularTourModels.length,
                  itemBuilder: (context, index) {
                    return PopularTours(
                      desc: popularTourModels[index].desc,
                      imgUrl: popularTourModels[index].imgUrl,
                      title: popularTourModels[index].title,
                      price: popularTourModels[index].price,
                      rating: popularTourModels[index].rating,
                    );
                  }),
                
           ),
          const SizedBox(height: 30),
          const Text("Lastest news"),
          _buildScrollSlider(),
          const SizedBox(height: 30),
          const Text("Categories"),
          _buildCategoriesBar(),
         (!status) ?  Container(): _buildStaggredItems(),
          const SizedBox(height: 30),

        ],),))

     ));
  }

  Widget _buildHeader(){
    String name = "Lam";
    TextStyle style = TextStyle(fontWeight: FontWeight.bold, fontSize: 25);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hello $name", style: style),
          Text("Explore Viet Nam with us", style: style)
      ],)
    );
  }

   Widget _buildSearchs() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        GestureDetector(child: Container(
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text("Looking for place ...", style: TextStyle(color: Colors.grey[700])),
               Icon(Icons.search, color: Colors.grey[700])
            ],
          )
        )),
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          GestureDetector(
            onTap:() {
              getImage();
            } ,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
              decoration: BoxDecoration(color: Colors.grey[200] , borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Icon(Icons.add_a_photo_outlined, size:30),)
          ),
           GestureDetector(
             onTap: ()  {
               getFromGallery();
               },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
              decoration: BoxDecoration(color: Colors.grey[200] , borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Icon(Icons.photo_camera_back, size: 30),)
          )
        ],)
      ],)
    );
  }

  Widget _buildScrollSlider(){
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: BoardingScreen())
      ;
  }
  Widget _buildCategoriesBar(){
    return 
  Container(
    height: 60,
    margin: EdgeInsets.only(top: 10),
    child:   ListView.builder(
      padding: EdgeInsets.only(bottom: 15),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index){
        return  GestureDetector(
         onTap: (){},
         child: Container(
           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
           margin: const EdgeInsets.only(right: 15),
           child: Text(categories[index].name),
           decoration: BoxDecoration(
             color: Colors.white,
             boxShadow: [
              BoxShadow(
                  color: categories[index].color,
                  blurRadius: 3.0,
                  offset: Offset(3, 3))
            ]
           ),
           ),);
      },
      )
  );
  }

  Widget _buildStaggredItems(){
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        primary: false,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        itemCount: placeList.length,
        staggeredTileBuilder: (int index) =>
      new StaggeredTile.fit(2),
        itemBuilder: (context, index) => PlaceItem(location: placeList[index]),
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
                  'Image number ${location.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                 Text(
                  location.origin,
                  style: const TextStyle(color: Colors.grey),
                ),
                 Text(
              location.voice,
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

List <Category> categories = [
  Category(color: Colors.grey, name: "All"),
  Category(color: Colors.green, name: "Food"),
  Category(color: Colors.blue, name: "Destination"),
  Category(color: Colors.red, name: "History"),
  Category(color: Colors.orange, name: "Music"),
  Category(color: Colors.yellow, name: "Heritage"),
  Category(color: Colors.purple, name: "Languague"),
];

class Category {
  final String name;
  final Color color;

  const Category({this.color, this.name});
}

class CountryListTile extends StatelessWidget {
  final String label;
  final String countryName;
  final int noOfTours;
  final double rating;
  final String imgUrl;
  CountryListTile(
      {@required this.countryName,
      @required this.label,
      @required this.noOfTours,
      @required this.rating,
      @required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              height: 220,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 200,
            width: 150,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 8, top: 8),
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white38),
                        child: Text(
                          label ?? "New",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Thailand",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "18 Tours",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                        margin: EdgeInsets.only(bottom: 10, right: 8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white38),
                        child: Column(
                          children: [
                            Text(
                              "4.5",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


class PopularTours extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String price;
  final double rating;
  PopularTours(
      {@required this.imgUrl,
      @required this.rating,
      @required this.desc,
      @required this.price,
      @required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Details(
                      imgUrl: imgUrl,
                      placeName: title,
                      rating: rating,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            color: Color(0xffE9F4F9), borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                width: 110,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff4E6059)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff89A097)),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    price,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff4E6059)),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 10, right: 8),
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0xff139157)),
                child: Column(
                  children: [
                    Text(
                      "$rating",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}