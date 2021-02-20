import 'package:flutter/material.dart';
class CardSlideRecognition extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top:10),
      width: MediaQuery.of(context).size.width*0.95,
      height:MediaQuery.of(context).size.height *0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image:DecorationImage(
          image:AssetImage('assets/images/img11.jpg'),
          fit:BoxFit.cover,
        )
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow:[
            BoxShadow(color:Colors.black12, spreadRadius:0.5),
          ],
          gradient: LinearGradient(
            colors: [Colors.black12, Colors.black87],
            begin: Alignment.center,
            stops: [0.4, 1],
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children:[
            Positioned(
              right:10,
              left:10,
              bottom:10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text('Bún đậu',
                  style:TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize:30,
                  )),
                  Text('Phần trăm nhận diện: 89%',
                  style:TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize:15,
                  ))
                ]
              ),
            )
          ],
        )
      )
    );
  }
}