
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter_vietnam_app/services/service.dart';

class ImageQuery extends StatefulWidget {
  final File image;
  const ImageQuery({this.image});

 @override
  _ImageQueryState createState() => _ImageQueryState();
}

class _ImageQueryState extends State<ImageQuery> {
  bool _status = false;
  LocationList _locationList ;
  String imageName = "";
  var result;
  final ServiceMain _userService = serviceLocator<ServiceMain>();

  void setStatus(bool status){
    setState(() {
       _status = status;
    });
  }

  void _startQuery() async {
    setStatus(false);
    String temp = await _userService.sendImage(file: widget.image);
    setState(() {
       imageName = temp;
    });
    print("Parse image to server");
    setStatus(true);
  }
  
  void _startPredict() async {
        setStatus(false);

    var temp = await _userService.getPredictions(file: imageName);
    setState(() {
    result = temp; 
});
    setStatus(true);
  }

  @override 
  Widget build(BuildContext context){
    return SafeArea(child: Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: (){
          _startQuery();
        //  _startPredict();
        },
        child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(color: Colors.green),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      (_status) ? Text("Search", style: TextStyle(color: Colors.white))  :Container(height: 3, width: 30, child:  Center(child: CircularProgressIndicator()),)
        ],)),),
      body: 
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView( 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Text("Your image", style: TextStyle(color: Colors.white) ),
              decoration: BoxDecoration(
                color: Colors.redAccent
              ),
            ),
            const SizedBox(height: 20),
            Image.file(widget.image),

          ],
        )
      ))
    ));
  }
}