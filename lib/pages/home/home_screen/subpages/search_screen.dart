import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/widgets/detail_card.dart';
import 'package:flutter_vietnam_app/widgets/long_card_recycle.dart';
void main(){
  runApp(MaterialApp(
    home: SearchScreen(),
  ));
}
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController contrl=TextEditingController();
  double _swipeStartX;
  String _swipeDirection;
  String valueInput;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragStart: (e){
          _swipeStartX=e.globalPosition.dx;
        },
        onHorizontalDragUpdate: (e){
          _swipeDirection=(e.globalPosition.dx>_swipeStartX)?'Right':'Left';
        },
        onHorizontalDragEnd: (e){
          if(_swipeDirection=='Right'){
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              _buildSearchs(),
              SizedBox(height: 10,),
              Row(children: [
                DetailCard(),
                DetailCard(),
              ],),
              CardSlideRecognition(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSearchs() {
    return Container(
      margin: EdgeInsets.all(5),
      alignment: Alignment.center,
      child:Container(
        //padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
        width: MediaQuery.of(context).size.width-10,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),border: Border.all(width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child:TextField(
                controller: contrl,
                decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Looking for places',
                hintStyle: TextStyle(color:Colors.black),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15)),
                onChanged: (value){
                  valueInput=value;
                  print(valueInput);
                },
            )
          ),
          Icon(Icons.camera_alt),
          SizedBox(width: 5,),
          Icon(Icons.image)
          ],
        )
      )
    );
  }
}