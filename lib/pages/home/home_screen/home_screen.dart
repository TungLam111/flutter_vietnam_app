import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vietnam_app/models/item.dart';
import 'package:flutter_vietnam_app/common/widgets/scroll_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_vietnam_app/common/widgets/pages/page_location.dart';
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
  
  File _image;
  String _error;
  final picker = ImagePicker();

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
  @override
  void initState() {
    country = getCountrys();
    popularTourModels = getPopularTours();

    super.initState();
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
          leading: Icon(Icons.menu, color: Color(0xff139157)),
          actions: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Icon(Icons.settings, color:Color(0xff139157)))
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
          const SizedBox(height: 30),
          _buildHeader(),
          const SizedBox(height: 30),
          _buildSearchs(),
          const SizedBox(height: 30),
           Container(
             padding: EdgeInsets.symmetric(horizontal: 15),
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
           Container(
             padding: EdgeInsets.symmetric(horizontal: 15),
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
          _buildScrollSlider(),
          const SizedBox(height: 30),
          _buildCategoriesBar(),
          const SizedBox(height: 30),
          _buildStaggredItems(),
          const SizedBox(height: 30),

        ],),)

     ));
  }

  Widget _buildHeader(){
    String name = "Lam";
    TextStyle style = TextStyle(fontWeight: FontWeight.bold, fontSize: 25);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
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
      padding: EdgeInsets.symmetric(horizontal: 15),
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
            padding: EdgeInsets.symmetric(horizontal: 15),
      child: BoardingScreen())
      ;
  }
  Widget _buildCategoriesBar(){
    return Container();
  }

  Widget _buildStaggredItems(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        primary: false,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 4,
        itemCount: placeList.length,
        staggeredTileBuilder: (int index) =>
      new StaggeredTile.count(2, index.isEven ? 2 : 1),
        itemBuilder: (context, index) => PlaceItem(index: index),
      ),
    );

  }
}

class PlaceItem extends StatelessWidget {
  final int index;
  const PlaceItem({this.index});

  @override 
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                placeList[index].image,
              ),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                placeList[index].itemName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                placeList[index].location,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<Item> placeList = [
  Item(image: "images/img1.jpg", itemName: "Destination 1" ,location: "Location 1"),
  Item(image: "images/img2.png", itemName: "Destination 2" ,location: "Location 2"),
  Item(image: "images/img3.jpg", itemName: "Destination 3" ,location: "Location 3"),
  Item(image: "images/img4.jpg",itemName: "Destination 4" ,location: "Location 4"),
  Item(image: "images/img5.jpg", itemName: "Destination 5" ,location: "Location 5"),
  Item(image: "images/img6.png", itemName: "Destination 6" ,location: "Location 6"),
  Item(image: "images/img7.jpg", itemName: "Destination 7" ,location: "Location 7" ),
  Item(image: "images/img8.png", itemName: "Destination 8" ,location: "Location 8"),
  Item(image: "images/img9.jpg", itemName: "Destination 9" ,location: "Location 9" ),
  Item(image: "images/img10.jpg", itemName: "Destination 10" ,location: "Location 10"),
  Item(image: "images/img11.jpg",itemName: "Destination 11" ,location: "Location 11" ),
  Item(image: "images/img12.jpg", itemName: "Destination 12" ,location: "Location 12"),
];

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