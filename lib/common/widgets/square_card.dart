import 'package:flutter/material.dart';
class CardSquare extends StatelessWidget{
  final String assetImg;
  final String textLabel;
  CardSquare({Key key,this.assetImg,this.textLabel});
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top:10),
      width: MediaQuery.of(context).size.width/2,
      height:MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image:DecorationImage(
          image:AssetImage(assetImg),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text(textLabel,
                  style:TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize:20,
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