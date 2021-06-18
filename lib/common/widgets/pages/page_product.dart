//this page is for showing the detail of product (for image recognition)
import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/common/widgets/pages/page_product_2.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/pages/home/home_screen/youtube.dart';
import 'package:flutter_vietnam_app/pages/home/home_screen/flip_card.dart';
class DescriptionProduct extends StatefulWidget {
  final Location location;
  const DescriptionProduct({this.location});
  @override
  _DescriptionProductState createState() => _DescriptionProductState();
}

class _DescriptionProductState extends State<DescriptionProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          ImageIntro(
            location: widget.location,
          ),
          Detail(location: widget.location)
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

class ImageIntro extends StatefulWidget {
  final Location location;
  const ImageIntro({this.location});
  @override
  _ImageIntroState createState() => _ImageIntroState();
}

class _ImageIntroState extends State<ImageIntro> {
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              resizeToAvoidBottomPadding: true,
              body: Stack(children: [
                PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  controller: _pageController,
                  itemCount: widget.location.images.length + 1,
                  itemBuilder: (context, index) {
                    if (index == widget.location.images.length)
                      return Youtube(idLinkYoutube: widget.location.videoCode);
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(widget.location.images[index]),
                        fit: BoxFit.cover,
                      )),
                    );
                  },
                ),
                Positioned(
                 // alignment: Alignment.bottomCenter,
                 bottom:0, right: 0, left: 0,
                  child: Container(
                //    height: 250,
                      decoration: BoxDecoration(
                        //  boxShadow:[
                        //   BoxShadow(color:Colors.black12, spreadRadius:0.5),
                        // ],
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black87],
                          begin: Alignment.center,
                          stops: [0.2, 1],
                          end: Alignment.bottomCenter,
                          ),
                       ),
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        child: Icon(
                                            Icons.arrow_back_ios_rounded,
                                            color: Colors.white),
                                        onTap: () {
                                          setState(() {
                                            _currentPage = (_currentPage > 0)
                                                ? _currentPage - 1
                                                : 0;
                                            _pageController.animateToPage(
                                              _currentPage,
                                              duration: Duration(
                                                milliseconds: 200,
                                              ),
                                              curve: Curves.easeIn,
                                            );
                                          });
                                        }),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                        child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.white),
                                        onTap: () {
                                          setState(() {
                                            _currentPage = (_currentPage <
                                                    widget.location.images
                                                            .length +
                                                        1)
                                                ? _currentPage + 1
                                                : widget.location.images.length;
                                            _pageController.animateToPage(
                                              _currentPage,
                                              duration: Duration(
                                                milliseconds: 200,
                                              ),
                                              curve: Curves.easeIn,
                                            );
                                          });
                                        })
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                _buildFlip(),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  color: Colors.black, 
                                  child: Text(widget.location.origin,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ))
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(widget.location.subtitle ?? "",
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                               
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Text(
                                          'See more',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Icon(Icons.keyboard_arrow_up,
                                            color: Colors.white, size: 30)
                                      ],
                                    ),
                                  ),
                                )
                              ]))),
                ),
                Align(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: Colors.white),
                                  padding: EdgeInsets.all(12),
                                  child: Icon(Icons.arrow_back_ios_rounded,
                                      size: 15))),
                        ],
                      ),
                    ],
                  ),
                ))
              ]));
        });
  }
    Widget _buildFlip() {
    return Column(
      children: [
        Container(
       //   height: 50, width: 200,
          child: FlipCard(
            speed: 3000,
            //   direction: _direction, // default
            front: 
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child:  Text(
                  widget.location.name.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
                ),
              
            back: 
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade200,),
                    child:    Text(
                  widget.location.name.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
                  
                ),
             
             
          ),
        ),
      ],
    );
  }
}
