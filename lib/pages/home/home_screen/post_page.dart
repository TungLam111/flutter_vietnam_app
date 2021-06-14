import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vietnam_app/common/widgets/preferred_size_appbar.dart';
import 'package:flutter_vietnam_app/common/widgets/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class PostPage extends StatefulWidget {
  final Post post;
  PostPage({this.post});
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with TickerProviderStateMixin {
  final _firestore = Firestore.instance;
  int _ratingBarMode = 1;
  double _rating;
  IconData _selectedIcon;
  TextEditingController _ratingController;

  double _initialRating = 2.0;
  bool _isVertical = false;
  final _auth = FirebaseAuth.instance;

  int _counter = 0;
  ScoreWidgetStatus _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
  final duration = new Duration(milliseconds: 300);
  final oneSecond = new Duration(seconds: 1);
  Timer holdTimer, scoreOutETA;
  AnimationController scoreInAnimationController,
      scoreOutAnimationController,
      scoreSizeAnimationController;
  Animation scoreOutPositionAnimation;
  List<Asset> assetList ;
  void initState() {
    super.initState();
    getCurrentUser();
    assetList = [];
    _counter = widget.post.countLike;
    _ratingController = TextEditingController(text: '');
    _rating = _initialRating;
    scoreInAnimationController = new AnimationController(
        duration: new Duration(milliseconds: 150), vsync: this);
    scoreInAnimationController.addListener(() {});

    scoreOutAnimationController =
        new AnimationController(vsync: this, duration: duration);
    scoreOutPositionAnimation = new Tween(begin: 100.0, end: 150.0).animate(
        new CurvedAnimation(
            parent: scoreOutAnimationController, curve: Curves.easeOut));
    scoreOutPositionAnimation.addListener(() {
      setState(() {});
    });
    scoreOutAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
      }
    });

    scoreSizeAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 150));
    scoreSizeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        scoreSizeAnimationController.reverse();
      }
    });
    scoreSizeAnimationController.addListener(() {
      setState(() {});
    });
  }

  void dispose() {
    scoreInAnimationController.dispose();
    scoreOutAnimationController.dispose();
    super.dispose();
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

  void increment(Timer t) {
    scoreSizeAnimationController.forward(from: 0.0);
    setState(() {
      _counter++;
    });
     _firestore.collection("post").document(widget.post.reference.documentID).updateData({"count_like": _counter });
  }

  void onTapDown(TapDownDetails tap) {
    // User pressed the button. This can be a tap or a hold.
    print("this");
    if (scoreOutETA != null) {
      scoreOutETA.cancel(); // We do not want the score to vanish!
      print("score cancel");
    }
    if (_scoreWidgetStatus == ScoreWidgetStatus.BECOMING_INVISIBLE) {
      // We tapped down while the widget was flying up. Need to cancel that animation.
      scoreOutAnimationController.stop(canceled: true);
      _scoreWidgetStatus = ScoreWidgetStatus.VISIBLE;
    } else if (_scoreWidgetStatus == ScoreWidgetStatus.HIDDEN) {
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_VISIBLE;
      scoreInAnimationController.forward(from: 0.0);
    }
    increment(null); // Take care of tap

    //holdTimer = new Timer.periodic(duration, increment); // Takes care of hold
  }

  void onTapUp(TapUpDetails tap) {
    print("that");
    // User removed his finger from button.
    scoreOutETA = new Timer(oneSecond, () {
      scoreOutAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_INVISIBLE;
    });
    //holdTimer.cancel();
    print("hold timer canel");
  }
 
  Widget getScoreButton(int value) {
    var scorePosition = 0.0;
    var scoreOpacity = 0.0;
    var extraSize = 0.0;
    switch (_scoreWidgetStatus) {
      case ScoreWidgetStatus.HIDDEN:
        break;
      case ScoreWidgetStatus.BECOMING_VISIBLE:
      case ScoreWidgetStatus.VISIBLE:
        scorePosition = scoreInAnimationController.value * 100;
        scoreOpacity = scoreInAnimationController.value;
        extraSize = scoreSizeAnimationController.value * 10;
        break;
      case ScoreWidgetStatus.BECOMING_INVISIBLE:
        scorePosition = scoreOutPositionAnimation.value;
        scoreOpacity = 1.0 - scoreOutAnimationController.value;
    }
    return new Positioned(
        child: new Opacity(
            opacity: scoreOpacity,
            child: new Container(
                height: 50.0 + extraSize,
                width: 50.0 + extraSize,
                decoration: new ShapeDecoration(
                  shape: new CircleBorder(side: BorderSide.none),
                  color: Colors.blueGrey,
                ),
                child: new Center(
                    child: new Text(
               "+" + value.toString(),
                  style: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                )))),
        bottom: scorePosition);
  }

  Widget getClapButton() {
    // Using custom gesture detector because we want to keep increasing the claps
    // when user holds the button.

    var extraSize = 0.0;
    if (_scoreWidgetStatus == ScoreWidgetStatus.VISIBLE ||
        _scoreWidgetStatus == ScoreWidgetStatus.BECOMING_VISIBLE) {
      extraSize = scoreSizeAnimationController.value * 10;
    }
    return new GestureDetector(
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        child: new Container(
          height: 60.0 + extraSize,
          width: 60.0 + extraSize,
          padding: new EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.blueGrey, width: 1.0),
              borderRadius: new BorderRadius.circular(50.0),
              color: Colors.white,
              boxShadow: [
                new BoxShadow(color: Colors.blueGrey, blurRadius: 8.0)
              ]),
          child: new CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: new AssetImage("assets/images/hand.jpg"),
          ),
        ));
  }

    //upload for asset
  Future saveImage(List<Asset> asset) async {
    StorageUploadTask uploadTask;
    List<String> linkImage = [];
    for (var value in asset) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
      ByteData byteData = await value.requestOriginal(quality: 70);
      var imageData = byteData.buffer.asUint8List();
      uploadTask = ref.putData(imageData);
      String imageUrl;
      await (await uploadTask.onComplete).ref.getDownloadURL().then((onValue) {
        imageUrl = onValue;
      });
      linkImage.add(imageUrl);
    }
    return linkImage;
  }
   
  @override
  Widget build(BuildContext context) {
     var data = _firestore
        .collection("users")
        .where('email', isEqualTo: widget.post.poster);
    var postStream = _firestore.collection("post").document(widget.post.reference.documentID);
    var comments = _firestore
        .collection("comment").where('location', isEqualTo: widget.post.reference.documentID);
    return StreamBuilder<QuerySnapshot>(
        stream: data.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          var user = snapshot.data.documents[0];

          return StreamBuilder<QuerySnapshot>(
              stream: comments.snapshots(),
              builder: (context, snap) {
                if (!snap.hasData)
                  return Center(child: CircularProgressIndicator());
                List<DocumentSnapshot> commens_post = snap.data.documents;
                return StreamBuilder(
                  stream: postStream.snapshots(),
                  builder: (context, snapShot) {
                      if (!snapShot.hasData)
                  return Center(child: CircularProgressIndicator());
                  Post post = Post.fromSnapshot(snapShot.data);
                //  print(post.countLike);
                 // print(snapshot.data);
                    return Scaffold(
                      resizeToAvoidBottomInset: true,
                      resizeToAvoidBottomPadding: true,
                      //    bottomNavigationBar: ,
                      floatingActionButton: new Padding(
                          padding: new EdgeInsets.only(right: 20.0),
                          child: new Stack(
                            alignment: FractionalOffset.center,
                            overflow: Overflow.visible,
                            children: <Widget>[
                              getScoreButton(post.countLike),
                              getClapButton(),
                            ],
                          )),
                      body: Material(
                          child: OBCupertinoPageScaffold(
                        resizeToAvoidBottomInset: true,
                        navigationBar: OBThemedNavigationBar(
                            autoLeading: true, title: "Your reading"),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, bottom: 25),
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(post.category,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16)),
                                  Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(post.postTime),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 16))
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(post.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25))),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                      "Vietcetera (vietcetera.com) là một nền tảng nội dung với hàng triệu độc giả mỗi tháng từ khắp Việt Nam. Nay với ứng dụng điện thoại, người dùng có cập nhật nội dung của Vietcetera một cách tiện lợi và nhanh chóng.",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ))),
                              Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(user["photoUrl"]),
                                        radius: 30,
                                      ),
                                      SizedBox(width: 20),
                                      Text("@${user["displayName"]}".toString(),
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    children: post.images.map((String e) {
                                    return Image.network(e);
                                  }).toList())),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Column(
                                  children: post.content.map((e) {
                                    return Padding( 
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: Column(
                                        children: [
                                          (e["type"] == "text") ? Text(e["value"].toString(), style: TextStyle(
                                          color: Colors.blueGrey, fontSize: 17)) : Image.network(e["value"].toString()),
                                          SizedBox(height: 10),
                                          (e["type"] == "image") ? Text(e["title"].toString(), style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)) : SizedBox()
                                        ])
                                    );
                                  }).toList()
                                )
                              ),
                          
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Wrap(
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
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                margin: EdgeInsets.only(bottom: 20),
                                child: Text("Comments",
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 0.0),
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    primary: false,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            Divider(),
                                    itemCount: commens_post.length,
                                    itemBuilder: (context, index) {
                                      Comment comment = Comment.fromSnapshot(
                                          commens_post[
                                              index]); 
                                      var dataComment = _firestore
                                          .collection("users")
                                          .where('email',
                                              isEqualTo: comment.sender);
                                      return StreamBuilder<QuerySnapshot>(
                                          stream: dataComment.snapshots(),
                                          builder: (context, snapshotComment) {
                                            if (!snapshotComment.hasData)
                                              return Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            var userComment =
                                                snapshotComment.data.documents[0];
                                            return Container(
                                                child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          userComment["photoUrl"]
                                                              .toString()),
                                                    ),
                                                    SizedBox(width: 20),
                                                    Expanded(
                                                      child: Text(comment.comment
                                                          .toString()),
                                                    )
                                                  ],
                                                ),
                                                if (comment.images.length > 0)
                                                  imageGridView(comment.images),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    //   if (comment.rating!= null) Text(comment.rating.toString()),
                                                    if (comment.rating != null)
                                                      _ratingBarComment(comment
                                                          .rating
                                                          ?.toDouble()),
                                                    Text(
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(comment.time),
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13))
                                                  ],
                                                )
                                              ],
                                            ));
                                          });
                                    },
                                  )),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: _ratingController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                    hintText: 'Leave your comment',
                                    labelText: 'Typing',
                                    labelStyle: TextStyle(color: Colors.black),
                                    prefixIcon: GestureDetector( 
                                      child: Icon(Icons.image, color: Colors.grey),
                                      onTap: ()async{
                                        loadAssets();
                                      },
                                    ),
                                    suffixIcon: MaterialButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () async {
                                            List<String> listImages = await saveImage(assetList);              
                          Comment newPet = Comment(
                            sender: loggedInUser.email, 
                            comment:  _ratingController.text, 
                            location: post.reference.documentID,
                            rating: _rating,
                            
                            time: DateTime.now(),
                            images: listImages );
                          _firestore
        .collection("comment").add(newPet.toJson());
        
                                        setState(() {
                                          assetList.clear();
                                          _rating = 0;
                                          _ratingController.clear();
                                        });
                                      },
                                      child: Text('Send'),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, bottom: 10, top: 10),
                                  child: _ratingBar(_ratingBarMode))
                            ],
                          )),
                        ),
                      )),
                    );
                  }
                );
              });
        });
  }
 //TODO: load multi image
  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: assetList,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#000000",
          actionBarTitle: "Pick Product Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
    setState(() {
      assetList = resultList;
    });
  }
  Widget imageGridView(List<String> listImages) {
    return GridView.count(
        primary: false,
        padding: EdgeInsets.zero,
        crossAxisCount: 3,
        shrinkWrap: true,
        children: listImages.map((e) {
          return Container(
              height: (MediaQuery.of(context).size.width - 30 - 50) * 0.3 ,
              width:(MediaQuery.of(context).size.width - 30 - 50) * 0.3  ,
              padding: EdgeInsets.all(5), child: Image.network(e.toString(), fit: BoxFit.cover,));
        }).toList());
  }

  Widget _ratingBar(int mode) {
        return RatingBar.builder(
          initialRating: _initialRating,
          minRating: 1,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 25.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          glowColor: Colors.yellow,
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
  }

  Widget _ratingBarComment(double rating) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 25.0,
      unratedColor: Colors.amber.withAlpha(50),
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
    );
  }
}

enum ScoreWidgetStatus { HIDDEN, BECOMING_VISIBLE, VISIBLE, BECOMING_INVISIBLE }
