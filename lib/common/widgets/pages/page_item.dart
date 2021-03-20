//this page is for showing the detail of product (for image recognition)
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/detail.dart';
import 'package:flutter_vietnam_app/models/item_parent.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter_vietnam_app/services/service.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cached_network_image/cached_network_image.dart';
class DestinationDetail extends StatefulWidget {
  const DestinationDetail();
  @override
  _DestinationDetailState createState() => _DestinationDetailState();
}

class _DestinationDetailState extends State<DestinationDetail> {
  double _panelHeightOpen;
  double _panelHeightClosed;
  Destination _destination;
  bool status = false;
  Size _size;
 final PageController _pageController = PageController(initialPage: 0, keepPage: true);
  int _currentPage = 0;
  final ServiceMain _userService = serviceLocator<ServiceMain>();
  
  void getDestination() async {
    setStatus(false);
     DestinationList temp = await _userService.getLocal();
     setState((){
       _destination = temp.categories[0];
     });
     setStatus(true);
  }
 void setStatus(bool sta){
    setState(() {
      status = sta;
    });
  }
  @override
  void initState(){
    super.initState();
    getDestination();
  }

  @override
  Widget build(BuildContext context){
    _panelHeightOpen = MediaQuery.of(context).size.height * .9;
    _panelHeightClosed = MediaQuery.of(context).size.height * .7;
    _size = MediaQuery.of(context).size;
    return Material(
      
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[

          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            
            body: (status) ?  _body(context) : const SizedBox(height: 0, width: 0),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState((){
            }),
          ),      

          Positioned(
            top: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).padding.top,
                  color: Colors.transparent,
                )
              )
            )
          ),
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc){
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          SizedBox(height: 12.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
              ),
            ],
          ),

          SizedBox(height: 18.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Explore Pittsburgh",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),

          SizedBox(height: 36.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _button("Popular", Icons.favorite, Colors.blue),
              _button("Food", Icons.restaurant, Colors.red),
              _button("Events", Icons.event, Colors.amber),
              _button("More", Icons.more_horiz, Colors.green),
            ],
          ),

          SizedBox(height: 36.0,),

          (status) ?  Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text("Items", style: TextStyle(fontWeight: FontWeight.w600,)),

                SizedBox(height: 12.0,),

                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _destination.items.categories.length,
                  itemBuilder: (context, index){
                    Item item = _destination.items.categories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Image.network(item.images[0], height: 80,),
                          const SizedBox(width: 20),
                          Expanded(child: 
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text("${item.name}", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15)),
                            Text("${item.price} VND", style: TextStyle(color: Colors.grey[300], fontSize: 12))
                          ],)
                          ,)
                      ],));
                  },
                )
              ],
            ),
          ) : Container(),

          SizedBox(height: 36.0,),

          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("About", style: TextStyle(fontWeight: FontWeight.w600,)),

                SizedBox(height: 12.0,),

                Text(
                  """Pittsburgh is a city in the state of Pennsylvania in the United States, and is the county seat of Allegheny County.Pittsburgh is a city in the state of Pennsylvania in the United States, and is the county seat of Allegheny County. 
                  """,
                  softWrap: true,
                ),
              ],
            ),
          ),
          
           (status) ?Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text("Nearby", style: TextStyle(fontWeight: FontWeight.w600,)),

                SizedBox(height: 12.0,),

                Container(height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount:  _destination.nearby.categories.length,
                  itemBuilder: (context, index){
                    Destination _des = _destination.nearby.categories[index];
                    return MiniItem(destination: _des,);
                  })
                )
              ],
            ),
          ) : Container(),
             (status) ?Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text("Related", style: TextStyle(fontWeight: FontWeight.w600,)),

                SizedBox(height: 12.0,),

                Container(height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount:  _destination.related.categories.length,
                  itemBuilder: (context, index){
                    Destination _des = _destination.related.categories[index];
                    return MiniItem(destination: _des,);
                  })
                )
              ],
            ),
          ) : Container(),
(status) ?Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text("Related Nearby", style: TextStyle(fontWeight: FontWeight.w600,)),

                SizedBox(height: 12.0,),

                Container(height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount:  _destination.relatedNearby.categories.length,
                  itemBuilder: (context, index){
                    Destination _des = _destination.relatedNearby.categories[index];
                    return MiniItem(destination: _des,);
                  })
                )
              ],
            ),
          ) : Container(),
          SizedBox(height: 24,),
        ],
      )
    );
  }

  Widget _button(String label, IconData icon, Color color){
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )]
          ),
        ),

        SizedBox(height: 12.0,),

        Text(label),
      ],

    );
  }

  Widget _body(BuildContext context){
    return Column(
    children:[
      Stack(children: [
  Container(
    height: MediaQuery.of(context).size.height * 0.3,
    child: PageView.builder(
    
    onPageChanged: (value){
        setState(() {
          _currentPage = value;  
        });
      },
      controller: _pageController,
    itemCount: _destination.images.length,
    itemBuilder: (context, index){
      return Padding(padding: EdgeInsets.all(10),
      child: CachedNetworkImage(
                        imageUrl: _destination.images[index],
                        fit: BoxFit.cover,
                      ));
    })),
    
    Positioned(
      top: MediaQuery.of(context).size.height * 0.3 - 20,
      left:  MediaQuery.of(context).size.width * 0.5 - 20,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildPageIndicator()
    )),
    Positioned(
      left: 20, top: 30,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Icon(Icons.arrow_back_ios_rounded)))
      ],)
    ]
    ); 
  }
   List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _destination.images.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 5.0,
      width: isActive ? 10.0 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.grey : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
  }

  class MiniItem  extends StatelessWidget {
    final Destination destination;
    const MiniItem({this.destination});

    @override 
    Widget build(BuildContext context){
      return GestureDetector(
        child: Container(

                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(children: [
                            Container(
                              height: 200, width: 300,
                              child: CachedNetworkImage(imageUrl: destination.images[0] , fit: BoxFit.cover)),
                            Positioned(
                              bottom: 20, left: 20,
                               child: 
                                Container(
                                child: Text("${destination.avgRatings}/5", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              )
                            ,)
                            
                          ],),
                          const SizedBox(height: 5,),
                          Text(destination.types, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                          Text(destination.address, style: TextStyle(fontSize: 12)),
                          Text(destination.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Row(children: [
                            const Text("Gia trung binh"),
                            const SizedBox(width: 10),
                            Text("${destination.avgPrice} VND", style: TextStyle(fontWeight: FontWeight.bold))
                          ],)
                      ],)
                    ));
    }
  }