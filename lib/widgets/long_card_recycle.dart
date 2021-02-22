import 'package:flutter/material.dart';
class CardSlideRecognition extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top:10),
      width: MediaQuery.of(context).size.width* 0.95,
      height:MediaQuery.of(context).size.height *0.35,
      decoration: BoxDecoration(
         boxShadow:[
            BoxShadow(color:Colors.black12, spreadRadius:0.5),
          ],
        
        borderRadius: BorderRadius.circular(20),
        image:DecorationImage(
          image:AssetImage('assets/images/img11.jpg'),
          fit:BoxFit.cover,
          
        )
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
                  Text('Bún đậu Phan Dam Tung Lam',
                  maxLines: 3,
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
    );
  }
}