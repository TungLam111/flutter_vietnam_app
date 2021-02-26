import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(
    home: PageViewAnother(),
  ));
}
class PageViewAnother extends StatefulWidget {
  @override
  _PageViewAnotherState createState() => _PageViewAnotherState();
}

class _PageViewAnotherState extends State<PageViewAnother> {
  final PageController ctrl=PageController(initialPage: 0,keepPage: true);
  int page=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
      onPageChanged: (value){
        setState(() {
          page=value;  
        });
      },
      controller: ctrl,
      children: [
        APageView(
          imageAsset:'assets/images/mua_roi_sqr.jpg',
          bigText:'Ứng dụng VinTravel',
          description: 'Ứng dụng giới thiệu các cảnh đẹp, món ăn, trang phục Việt Nam',
          visibleButton: false,
        ),
        APageView(
          imageAsset: 'assets/images/com_lang_vong_sqr.jpg',
          bigText: 'Second',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ultricies ultrices diam, in laoreet velit scelerisque sed',
          visibleButton: false,
        ),
        APageView(
          imageAsset: 'assets/images/lua_sqr.jpg',
          bigText: 'Third',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ultricies ultrices diam, in laoreet velit scelerisque sed',
          visibleButton: true,
        )
      ],
    ),
    bottomSheet: Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _circleBar((page==0)),
          SizedBox(width: 5,),
          _circleBar((page-1==0)),
          SizedBox(width: 5,),
          _circleBar((page-2==0)),
        ],
      ),
    ),
  );
}
  Widget _circleBar(bool isActive){
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      height:12,
      width:12,
      decoration: BoxDecoration(
        color: isActive?Colors.green:Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );

  }
}
class APageView extends StatelessWidget {
  final String imageAsset;
  final String bigText;
  final String description;
  final bool visibleButton;
  APageView({this.imageAsset,this.bigText,this.description,this.visibleButton});
  @override
  Widget build(BuildContext context) {
    return Container(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Spacer(),
                    Image.asset(imageAsset,width: MediaQuery.of(context).size.width-30,)
                  ],
                ),
                SizedBox(height: 20,),
                Text(bigText,style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),),
                ),
                SizedBox(height: 20,),
                Opacity(
                  opacity: visibleButton? 1:0,
                  child: ElevatedButton(
                    onPressed: (){},
                    child: Text('DONE'),
                  ),
                )
              ],)
      );
  }
}