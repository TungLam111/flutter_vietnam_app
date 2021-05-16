import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class IconCard extends StatelessWidget {
  final String svgAssetPath;
  final String textLabel;
  IconCard({Key key,this.svgAssetPath,this.textLabel});
  @override
  Widget build(BuildContext context) {
    return Container(
      height:100,
      child: Card(
        shadowColor: Colors.black,
        shape:RoundedRectangleBorder(
          side: new BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(children: [
          Container(
            padding: EdgeInsets.fromLTRB(20,10,20,15),
            child: SvgPicture.asset(
              svgAssetPath,
              height:44,
              width:44,
              semanticsLabel:'Food Logo',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(textLabel,style:TextStyle(fontSize: 10,fontWeight:FontWeight.bold)),
          )
        ],)
      ),
    );
  }
}