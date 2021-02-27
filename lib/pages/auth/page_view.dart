import 'package:flutter/material.dart';
class PageViewAnother extends StatefulWidget {
  @override
  _PageViewAnotherState createState() => _PageViewAnotherState();
}

class _PageViewAnotherState extends State<PageViewAnother> {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0, keepPage: true);
  int _currentPage = 0;
  Size size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: BouncingScrollPhysics(),
      onPageChanged: (value){
        setState(() {
          _currentPage = value;  
        });
      },
      controller: _pageController,
      children: [
        APageView(
          imageAsset:'assets/images/mua_roi_sqr.jpg',
          titleAsset: 'assets/images/mua_roi_font.jpg',
          bigText:'Ứng dụng VinTravel',
          description: 'Ứng dụng giới thiệu các cảnh đẹp, món ăn, trang phục Việt Nam',
          visibleButton: false,
        ),
        APageView(
          imageAsset: 'assets/images/com_lang_vong_sqr.jpg',
          titleAsset: 'assets/images/com_lang_vong_font.jpg',
          bigText: 'Second',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ultricies ultrices diam, in laoreet velit scelerisque sed',
          visibleButton: false,
        ),
        APageView(
          imageAsset: 'assets/images/lua_sqr.jpg',
          titleAsset: 'assets/images/lua_ha_dong_font.jpg',
          bigText: 'Third',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ultricies ultrices diam, in laoreet velit scelerisque sed',
          visibleButton: true,
        ),
         APageView(
          imageAsset: 'assets/images/lua_sqr.jpg',
          titleAsset: 'assets/images/lua_ha_dong_font.jpg',
          bigText: 'Third',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ultricies ultrices diam, in laoreet velit scelerisque sed',
          visibleButton: true,
        )
      ],
    ),
    bottomSheet: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildPageIndicator(),
      ),
    ),
  );
}

 List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 5.0,
      width: isActive ? 20.0 : 8,
      decoration: BoxDecoration(
        color: isActive ? Color(0xff139157) : Colors.grey[400],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
class APageView extends StatelessWidget {
  final String imageAsset;
  final String titleAsset;
  final String bigText;
  final String description;
  final bool visibleButton;
  APageView({this.imageAsset,this.titleAsset,this.bigText,this.description,this.visibleButton});
  @override
  Widget build(BuildContext context) {
    return Container(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  //fit:StackFit.loose,
                  children: [
                    Container(
                      height:500,
                      alignment: Alignment.centerRight,
                      child: Image.asset(imageAsset,width: MediaQuery.of(context).size.width-30,)),
                    Positioned(
                      bottom: -5,
                      //right:0,
                      left:100,
                      child: Image.asset(titleAsset,
                        height: 100,
                        width: MediaQuery.of(context).size.width-30,))
                  ],
                ),
                //Spacer(),
                SizedBox(height: 10,),
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