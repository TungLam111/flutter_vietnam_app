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
import 'dart:math';
import 'dart:ui';
import 'package:flutter/painting.dart';
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
 
 FlipDirection _direction;
  @override
  void initState() {
    super.initState();
    _direction = FlipDirection.VERTICAL;
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
                  _buildFlip(),
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
            itemBuilder: (context, index) => PlaceItem(index: index,location: Location.fromSnapshot(snapshotDataDocument[index])),
          ),
        );
  }
  
  void callback(){
    if (_direction == FlipDirection.VERTICAL) {
          setState(() {
            _direction = FlipDirection.HORIZONTAL;
          });
    }
    else {
       setState(() {
            _direction = FlipDirection.VERTICAL;
          });
    }
       //print("cuuuuu");
    
  }
  Widget _buildFlip(){
    return   Column(
              children: [
           
                Container(
                  width: 180,
                  height: 180,
                  margin: EdgeInsets.only(top: 20),
                  child: FlipCard(
              //      onFlip : callback,
                    speed: 3000,
                 //   direction: _direction, // default
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
}

class PlaceItem extends StatelessWidget {
  final Location location;
  final int index;
  const PlaceItem({this.index,this.location});

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
    MaterialPageRoute(builder: (context) => DescriptionProduct(location: location,)),
  );
      },
      child:  Card(
      child:  
          Stack(
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
                progressIndicatorBuilder: (context, url, downloadProgress) => 
                              CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                         ),
                       ],
                     ),
                
                    ],
                  ),
                   Container(
                    height: 80,
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
                         Expanded(
                                                    child: Text(
                      location.description,
                      maxLines: 2,
                            style: const TextStyle(color: Colors.grey),
                        ),
                         ),
                      ],
                    ),
                  )
                ],
              ),
              
              Container( 
                height: random.toDouble() + 88,
                color: randomList[random2].withOpacity(0.9),
                child: Center(
                  child: Text("${location.name}", style: TextStyle(color:  Colors.white,fontSize: 30, fontWeight: FontWeight.bold))
                 )
              )
            ],
          ),
     
           
        
      
    ));
  }
}

List<Color> randomList = [Colors.red, Colors.yellow, Colors.green[900], Colors.teal, Colors.purple, Colors.orange, Colors.blue, Colors.limeAccent];

enum FlipDirection {
  VERTICAL,
  HORIZONTAL,
}

class AnimationCard extends StatelessWidget {
  AnimationCard({this.child, this.animation, this.direction});

  final Widget child;
  final Animation<double> animation;
  final FlipDirection direction;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        var transform = Matrix4.identity();
        transform.setEntry(3, 2, 0.001);
        if (direction == FlipDirection.VERTICAL) {
          transform.rotateX(animation.value);
        } else {
          transform.rotateY(animation.value);
        }
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: child,
    );
  }
}

typedef void BoolCallback(bool isFront);

class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  /// The amount of milliseconds a turn animation will take.
  final int speed;
  final FlipDirection direction;
  final VoidCallback onFlip;
  final BoolCallback onFlipDone;
  final bool flipOnTouch;

  const FlipCard(
      {Key key,
      @required this.front,
      @required this.back,
      this.speed = 500,
      this.onFlip,
      this.onFlipDone,
      this.direction = FlipDirection.HORIZONTAL,
      this.flipOnTouch = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FlipCardState();
  }
}

class FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> _frontRotation;
  Animation<double> _backRotation;

  bool isFront = true;
 FlipDirection _direction;
  @override
  void initState() {
    super.initState();
    _direction = FlipDirection.VERTICAL;
    controller = AnimationController(
        duration: Duration(milliseconds: widget.speed), vsync: this);
    _frontRotation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: pi / 2)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
      ],
    ).animate(controller);
    _backRotation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50.0,
        ),
      ],
    ).animate(controller);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (widget.onFlipDone != null) widget.onFlipDone(isFront);
      }
    });
   startTimer();
  }

  void toggleCard() {

    if (isFront) {
      controller.forward();
    } else {
      controller.reverse();
    }

    setState(() {
      isFront = !isFront;
    });
        if (widget.onFlip != null) {
      widget.onFlip();
    }
  }
  Timer _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
 

  void startTimer() {
    const oneSec = const Duration(milliseconds: 3600);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (seconds < 0) {
            timer.cancel();

           
          } else {
              toggleCardMany();
              
            seconds = seconds + 1;
            if (seconds > 59) {
              minutes += 1;
              seconds = 0;
              if (minutes > 59) {
                hours += 1;
                minutes = 0;
              }
            }
          }
        },
      ),
    );
  }

  void toggleCardMany(){
    toggleCard();
     if (_direction == FlipDirection.HORIZONTAL){
        setState(() {
               _direction = FlipDirection.VERTICAL;
             });
     }
     else {
        setState(() {
               _direction = FlipDirection.HORIZONTAL;
             });
     }
  }
  
  @override
  Widget build(BuildContext context) {
    final child = Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        _buildContent(front: true),
        _buildContent(front: false),
      ],
    );

    // if we need to flip the card on taps, wrap the content
    if (widget.flipOnTouch) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: null,
        child: child,
      );
    }
    return child;
  }

  Widget _buildContent({@required bool front}) {
    // pointer events that would reach the backside of the card should be
    // ignored
    return IgnorePointer(
      // absorb the front card when the background is active (!isFront),
      // absorb the background when the front is active
      ignoring: front ? !isFront : isFront,
      child: AnimationCard(
        animation: front ? _frontRotation : _backRotation,
        child: front ? widget.front : widget.back,
        direction: _direction,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _timer.cancel();
    super.dispose();
  }
}
