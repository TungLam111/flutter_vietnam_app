import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 3 bottom bars
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) ;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(icon: Icon(Icons.account_circle_rounded,color:Colors.black),
          onPressed: (){},
          ),
          title:Text('Hello ABC',
          style:TextStyle(color:Colors.black)),
          actions:[
            IconButton(icon:Icon(Icons.search,color:Colors.black),
            onPressed: (){},
            ),
            IconButton(icon: Icon(Icons.notifications,color: Colors.black,),
            onPressed: (){},
            )
          ]
        ),
      ),
      body:Column(
        children: [
          //Placeholder dùng để phác họa 
          Placeholder(fallbackWidth: 20,fallbackHeight: 150,),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconCustom(svgAssetPath: 'assets/icons/noodles.svg',textLabel: 'Món ăn'),
              IconCustom(svgAssetPath: 'assets/icons/tunic.svg',textLabel: 'Trang phục'),
              IconCustom(svgAssetPath: 'assets/icons/halong-bay-vietnam.svg',textLabel: 'Phong cảnh'),
              IconCustom(svgAssetPath: 'assets/icons/asian-hat.svg',textLabel: 'Lưu niệm'),
            ],),
          Row(
            children: [
              Placeholder(fallbackWidth: MediaQuery.of(context).size.width/2,fallbackHeight: MediaQuery.of(context).size.width/2,),
              Placeholder(fallbackWidth: MediaQuery.of(context).size.width/2,fallbackHeight: MediaQuery.of(context).size.width/2,)
            ],)
          ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: index,
        items:[
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
            label:'Home',
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.recommend),
            label:'Recommend',
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.account_circle_outlined),
            label:'Account',
          )
        ]
      ),

    );
  }
}
class CardSlide extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(

    );
  }
}
class IconCustom extends StatelessWidget {
  final String svgAssetPath;
  final String textLabel;
  IconCustom({Key key,this.svgAssetPath,this.textLabel});
  @override
  Widget build(BuildContext context) {
    return Container(
      height:100,
      child: Card(
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