import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/common/widgets/detail_card.dart';
import 'package:flutter_vietnam_app/common/widgets/long_card_recycle.dart';
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
      //resizeToAvoidBottomInset: false,
      //resizeToAvoidBottomPadding: false,
      body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildSearchs(),
              SizedBox(height: 10,),
              Row(children: [
                DetailCard(),
                DetailCard(),
              ],),
              CardSlideRecognition(),
              CardSlideRecognition(),
              CardSlideRecognition(),
              CardSlideRecognition(),
            ],
          )
          ),
        ),
      
    );
  }
  Widget _buildSearchs() {
    return Container(
      margin: EdgeInsets.all(10),
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
                hintStyle: TextStyle(color:Colors.grey[300]),
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