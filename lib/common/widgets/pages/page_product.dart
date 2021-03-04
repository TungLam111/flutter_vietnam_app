//this page is for showing the detail of product (for image recognition)
import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/common/widgets/pages/page_product_2.dart';
class DescriptionProduct extends StatefulWidget {
  @override
  _DescriptionProductState createState() => _DescriptionProductState();
}

class _DescriptionProductState extends State<DescriptionProduct> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageView(
        children: [
          NewWidget(),
          CloneBooking()
        ],
        scrollDirection: Axis.vertical,
      ),

    );
  }
}

class NewWidget extends StatefulWidget {
 @override
  _NewWidgetState createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  int _numOfImage = 4;
  final PageController _pageController = PageController(initialPage: 0, keepPage: true);
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: Stack(
        children:[
          
          PageView(
            onPageChanged: (value){
        setState(() {
          _currentPage = value;  
        });
      },
      controller: _pageController,
            children: [
            Container(
      decoration: BoxDecoration(
      image:DecorationImage(
        image:AssetImage('assets/images/img1_2.jpg'),
        fit:BoxFit.cover,
      )
          ),
          ),
          Container(
      decoration: BoxDecoration(
      image:DecorationImage(
        image:AssetImage('assets/images/img2.png'),
        fit:BoxFit.cover,
      )
          ),
          ),
          Container(
      decoration: BoxDecoration(
      image:DecorationImage(
        image:AssetImage('assets/images/img3 (2).jpg'),
        fit:BoxFit.cover,
      )
          ),
          ),
          Container(
      decoration: BoxDecoration(
      image:DecorationImage(
        image:AssetImage('assets/images/img1_2.jpg'),
        fit:BoxFit.cover,
      )
          ),
          )
          ],),
          
          Container(
      decoration: BoxDecoration(
        boxShadow:[
          BoxShadow(color:Colors.black12, spreadRadius:0.5),
        ],
      gradient: LinearGradient(
        colors: [Colors.black12, Colors.black87],
        begin: Alignment.center,
        stops: [0.2, 1],
        end: Alignment.bottomCenter,
        ),
      ),
      child:Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                SizedBox(height:30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  GestureDetector(
                    child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white),
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.arrow_back_ios_rounded, size: 15)
                  )),
                   GestureDetector(
                    child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white),
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.favorite_outline_rounded, size: 15)
                  ))
                ],),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  GestureDetector(child: Icon(Icons.arrow_back_ios_rounded, color: Colors.white), onTap: (){
                     setState(() {
                        _currentPage =  (_currentPage > 0) ? _currentPage-1 : 0;  
                        _pageController.animateToPage(
                          _currentPage,
                          duration: Duration(
                            milliseconds: 200,
                          ),
                          curve: Curves.easeIn,
                        );
        });
                  }),
                  SizedBox(width: 20,),
                   GestureDetector(child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white), onTap: (){
                     setState(() {
                        _currentPage =  (_currentPage < 3) ? _currentPage + 1 : 3;  
                        _pageController.animateToPage(
                          _currentPage,
                          duration: Duration(
                            milliseconds: 200,
                          ),
                          curve: Curves.easeIn,
                        );
                     });
                   })
                ],),
                SizedBox(height: 10,),
                Text('Find new places',
                style:TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize:30,
                )),
                SizedBox(height: 10,),
                Text('Quang Nam province',
                style:TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize:15,
                )),
                SizedBox(height: 10,),
                Text('Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...',
                style:TextStyle(
                  color: Colors.white,
                  fontSize:15,
                )),
                SizedBox(height: 10,),
                Row(children: [

                ],),
                InkWell(
                  onTap: (){},
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text('Xem thêm',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize:15,
                        ),),
                        Icon(Icons.keyboard_arrow_up,color:Colors.white,size:30)
                      ],
                    ),
                  ),
                )
                ]
            )
      )
      )
        ])
    ));
  }
}