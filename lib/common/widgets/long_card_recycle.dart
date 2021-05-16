import 'package:flutter/material.dart';
class CardSlideRecognition extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return GestureDetector(
          child: Container(
            decoration: BoxDecoration( 
              color: Colors.white,
              boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                  offset: Offset(2, 2))
            ]),
        margin: EdgeInsets.symmetric(vertical:5, horizontal: 15),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/food/1.png", height: 100),
            SizedBox(width: 20),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bun bo Hue", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.green[700],),
                  child: Text("Accuracy prediction 90%", style: TextStyle(color: Colors.white,fontSize: 13)),)
            ],),),
            Icon(Icons.arrow_forward_ios_rounded, size: 15)
        ],)
      
      ),
    );
  }
}