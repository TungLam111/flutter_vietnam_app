import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotateIcon extends StatefulWidget {
RotateIcon({this.close, this.color});
bool close;
Color color;
@override 
RotateIconState createState() => new RotateIconState();
}

class RotateIconState extends State<RotateIcon> with SingleTickerProviderStateMixin {
    AnimationController animationController;
  bool _close;
  
  void initState() {
    super.initState();
    
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 200), value: 0.0
    );
   animationController.reverse() ;
  }
 
  void dispose(){
    animationController.dispose();
    super.dispose();
  }
  @override 
  Widget build(BuildContext context){
  _close = widget.close;
  !_close ?  animationController.reverse() : animationController.forward() ;
  return AnimatedBuilder(
        animation: animationController,
        child: Icon(Icons.keyboard_arrow_down_rounded, color: widget.color, size: 25),
        builder: (BuildContext context, Widget _widget) {
          return Transform.rotate(
            angle: _close ? animationController.value * math.pi :  animationController.value * - math.pi ,
            child: _widget,
          );
        },
      );
  }
}