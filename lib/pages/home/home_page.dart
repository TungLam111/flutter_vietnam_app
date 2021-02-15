import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/widgets/long_card.dart';
import 'package:flutter_vietnam_app/widgets/icon_card.dart';
import 'package:flutter_vietnam_app/widgets/square_card.dart';
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
          style:TextStyle(color:Colors.black,fontSize: 20,)),
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
      body:SingleChildScrollView(
        child: Column(
          children: [
            //Placeholder dùng để phác họa 
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Row(
                children: [
                  SizedBox(width:10),
                  CardSlide(assetImg: 'assets/images/banh_chung.jpg',textLabel: 'Bánh chưng'),
                  SizedBox(width:10),
                  CardSlide(assetImg: 'assets/images/ao_dai.jpg',textLabel: 'Áo dài'),
                  SizedBox(width:10),
                  CardSlide(assetImg: 'assets/images/cha_gio.jpg',textLabel: 'Chả giò'),
                  SizedBox(width:10),
                ],
              )
            ),
            SizedBox(height: 10,),
            Row(
              children:[
                SizedBox(width:10),
                Container(
                  width:5,
                  height:20,
                  color: Colors.amber
                ),
                SizedBox(width:10),
                Text('Danh mục',style:TextStyle(fontSize: 15))
              ]
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconCard(svgAssetPath: 'assets/icons/noodles.svg',textLabel: 'Món ăn'),
                IconCard(svgAssetPath: 'assets/icons/tunic.svg',textLabel: 'Trang phục'),
                IconCard(svgAssetPath: 'assets/icons/halong-bay-vietnam.svg',textLabel: 'Phong cảnh'),
                IconCard(svgAssetPath: 'assets/icons/asian-hat.svg',textLabel: 'Lưu niệm'),
              ],),
            Row(
              children: [
                SizedBox(width: 10,),
                Expanded(child: CardSquare(assetImg:'assets/images/tranh_dong_ho.jpg' ,textLabel: 'Tranh Đông Hồ',)),
                SizedBox(width: 10,),
                Expanded(child: CardSquare(assetImg:'assets/images/bun_dau.jpg' ,textLabel: 'Bún Đậu',)),
                SizedBox(width: 10,),
              ],)
            ],
        ),
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

