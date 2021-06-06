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

class PostPage extends StatefulWidget {
  final Post post;
  PostPage({this.post});
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with TickerProviderStateMixin {
  final _firestore = Firestore.instance;
   int _counter = 0;
  ScoreWidgetStatus _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
  final duration = new Duration(milliseconds: 300);
  final oneSecond = new Duration(seconds: 1);
  Timer holdTimer, scoreOutETA;
  AnimationController scoreInAnimationController, scoreOutAnimationController,
      scoreSizeAnimationController;
  Animation scoreOutPositionAnimation;

  void initState() {
    super.initState();
    scoreInAnimationController = new AnimationController(duration: new Duration(milliseconds: 150), vsync: this);
    scoreInAnimationController.addListener((){
    });

    scoreOutAnimationController = new AnimationController(vsync: this, duration: duration);
    scoreOutPositionAnimation = new Tween(begin: 100.0, end: 150.0).animate(
      new CurvedAnimation(parent: scoreOutAnimationController, curve: Curves.easeOut)
    );
    scoreOutPositionAnimation.addListener((){
      setState(() {});
    });
    scoreOutAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
      }
    });

    scoreSizeAnimationController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 150));
    scoreSizeAnimationController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        scoreSizeAnimationController.reverse();
      }
    });
    scoreSizeAnimationController.addListener((){
      setState(() {});
    });
  }

  void dispose() {
   scoreInAnimationController.dispose();
   scoreOutAnimationController.dispose();
   super.dispose();
  }

  void increment(Timer t) {
    scoreSizeAnimationController.forward(from: 0.0);
    setState(() {
      _counter++;
    });
  }

  void onTapDown(TapDownDetails tap) {
    // User pressed the button. This can be a tap or a hold.
    print("this");
    if (scoreOutETA != null) {
      scoreOutETA.cancel(); // We do not want the score to vanish!
      print("score cancel");
    }
    if(_scoreWidgetStatus == ScoreWidgetStatus.BECOMING_INVISIBLE) {
      // We tapped down while the widget was flying up. Need to cancel that animation.
      scoreOutAnimationController.stop(canceled: true);
      _scoreWidgetStatus = ScoreWidgetStatus.VISIBLE;
    }
    else if (_scoreWidgetStatus == ScoreWidgetStatus.HIDDEN ) {
        _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_VISIBLE;
        scoreInAnimationController.forward(from: 0.0);
    }
    increment(null); // Take care of tap
   // holdTimer = new Timer.periodic(duration, increment); // Takes care of hold
  }

  void onTapUp(TapUpDetails tap) {
    print("that");
    // User removed his finger from button.
    scoreOutETA = new Timer(oneSecond, () {
      scoreOutAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_INVISIBLE;
    });
    holdTimer.cancel();
    print("hold timer canel");
  }

  Widget getScoreButton() {
    var scorePosition = 0.0;
    var scoreOpacity = 0.0;
    var extraSize = 0.0;
    switch(_scoreWidgetStatus) {
      case ScoreWidgetStatus.HIDDEN:
        break;
      case ScoreWidgetStatus.BECOMING_VISIBLE :
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
        child: new Opacity(opacity: scoreOpacity, child: new Container(
            height: 50.0 + extraSize,
            width: 50.0  + extraSize,
            decoration: new ShapeDecoration(
              shape: new CircleBorder(
                  side: BorderSide.none
              ),
              color: Colors.blueGrey,
            ),
            child: new Center(child:
            new Text("+" + _counter.toString(),
              style: new TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),))
        )),
        bottom: scorePosition
    );
  }

  Widget getClapButton() {
    // Using custom gesture detector because we want to keep increasing the claps
    // when user holds the button.

    var extraSize = 0.0;
    if (_scoreWidgetStatus == ScoreWidgetStatus.VISIBLE || _scoreWidgetStatus == ScoreWidgetStatus.BECOMING_VISIBLE) {
      extraSize = scoreSizeAnimationController.value * 10;
    }
    return new GestureDetector(
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        child: new Container(
          height: 60.0 + extraSize ,
          width: 60.0 + extraSize,
          padding: new EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.blueGrey, width: 1.0),
              borderRadius: new BorderRadius.circular(50.0),
              color: Colors.white,
              boxShadow: [
                new BoxShadow(color: Colors.blueGrey, blurRadius: 8.0)
              ]
          ),
          child: new CircleAvatar(
            backgroundColor: Colors.white,
              backgroundImage: new AssetImage("assets/images/hand.jpg"), 
             ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    var data = _firestore
        .collection("users")
        .where('email', isEqualTo: widget.post.poster);
    return StreamBuilder<QuerySnapshot>(
        stream: data.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          var user = snapshot.data.documents[0];
          return Scaffold(
              floatingActionButton: new Padding(
          padding: new EdgeInsets.only(right: 20.0),
          child: new Stack(
            alignment: FractionalOffset.center,
            overflow: Overflow.visible,
            children: <Widget>[
              getScoreButton(),
              getClapButton(),
            ],
          )
      ),
                      body: Material(
                        child: OBCupertinoPageScaffold(
                          
                  resizeToAvoidBottomInset: true,
                  navigationBar: OBThemedNavigationBar(autoLeading: true, title: "Your reading"),
                 child: Padding(
                   padding: EdgeInsets.only(left: 15, right: 15, bottom: 25),
                                  child: SingleChildScrollView( 
                     child: Column(children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(widget.post.category, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                           Text(
                                    DateFormat('dd/MM/yyyy')
                                        .format(widget.post.postTime),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic, fontSize: 16))
                         ],
                       ),

                       Padding(
                         padding: EdgeInsets.symmetric(vertical: 10),
                         child: Text(widget.post.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),

                        Padding( 
                          padding: EdgeInsets.only(bottom: 10),
                          child: 
                          Text("Vietcetera (vietcetera.com) là một nền tảng nội dung với hàng triệu độc giả mỗi tháng từ khắp Việt Nam. Nay với ứng dụng điện thoại, người dùng có cập nhật nội dung của Vietcetera một cách tiện lợi và nhanh chóng.",
                          style: TextStyle(color: Colors.grey)
                          )
                        ),
                        Padding( 
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(children: [
                            CircleAvatar(backgroundImage: NetworkImage(user["photoUrl"]), radius: 30,),
                            SizedBox(width: 20),
                            Text("@${user["displayName"]}".toString(), style: TextStyle(fontSize: 17, color: Colors.blueGrey, fontWeight: FontWeight.bold))
                          ],)
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Image.network(
                            widget.post.images[0]
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(widget.post.content, style: TextStyle(color: Colors.blueGrey))
                        ),
                        Padding(
                             padding: EdgeInsets.only(bottom: 10),
                            child: Wrap(
                                children: widget.post.tags.map((e) {
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
                           )
                     ],)
                   ),
                 )
              ),
            ),
          );
        });
  }
}
enum ScoreWidgetStatus {
  HIDDEN,
  BECOMING_VISIBLE,
  VISIBLE,
  BECOMING_INVISIBLE
}
