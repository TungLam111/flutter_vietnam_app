import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/pages/auth/login_screen.dart';

const Map<int, Color> _color = {0: Colors.green, 1: Colors.orange, 2: Colors.amber, 3: Colors.red };
class PageViewAnother extends StatefulWidget {
  @override
  _PageViewAnotherState createState() => _PageViewAnotherState();
}

class _PageViewAnotherState extends State<PageViewAnother> {
  final int _numPages = 4;
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  int _currentPage = 0;
  Size size;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _color[_currentPage].withOpacity(0.9),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
         //   color: Colors.red,
            child: Column(children: [
              Expanded(
                  child: PageView(
                physics: BouncingScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                    print(_currentPage);
                  });
                },
                controller: _pageController,
                children: [
                  APageView(
                    imageAsset: 'assets/images/com_lang_vong_sqr-removebg-preview.png',
                    bigText: 'Understanding about Vietnamese culture by images',
                    color: _color[_currentPage]
                  ),
                  APageView(
                    imageAsset: 'assets/images/mua_roi_sqr-removebg-preview.png',
                    bigText: 'Best destination recommendation for tourism',
                    color: _color[_currentPage]
                  ),
                  APageView(
                    imageAsset: 'assets/images/com_lang_vong_sqr-removebg-preview.png',
                    bigText: 'Provide the most tour recommendation service ',
                    color: _color[_currentPage]
                  ),
                  APageView(
                    imageAsset: 'assets/images/mua_roi_sqr-removebg-preview.png',
                    bigText: 'Connect with local enthusiastic guiders',
                    color: _color[_currentPage]
                  )
                ],
              )),
              Container(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
              )),
              Container(
                height: 80,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: _buildFreeSpace()),
              
            ])));
  }

  Widget _buildFreeSpace() {
    
     if (_currentPage == 3){
       return Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
             GestureDetector(
               onTap: () {
                 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Login()),
  );
               },
       child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.all(Radius.circular(20)),
           color: Colors.white,),
         child: Text("GET STARTED",style: TextStyle(color: _color[_currentPage].withOpacity(0.7)))
       ),),
         ],
       );
     }
     else return Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
       GestureDetector(

       child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.all(Radius.circular(20)),
           color: Colors.white,),
         child: Text("GET STARTED",style: TextStyle(color: _color[_currentPage].withOpacity(0.7)))
       ),),
       GestureDetector(
         onTap: (){
           setState(() {
            _currentPage = (_currentPage < 3) ? _currentPage+1 : _currentPage;
           });
         },
       child: Container(
         
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.all(Radius.circular(20)),
   ),
         child: Text("NEXT",style: TextStyle(color: Colors.white))
       ),)
     ],);
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
        color: isActive ? _color[_currentPage].withOpacity(0.7) : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class APageView extends StatelessWidget {
  final String imageAsset;
  final String bigText;
  final Color color;
  APageView({this.imageAsset, this.bigText, this.color});
  @override
  Widget build(BuildContext context) {
    const TextStyle _style = TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
    TextSpan _headText = TextSpan(text: bigText[0], style: _style.copyWith(color: color.withOpacity(0.8)) );
    TextSpan _bodyText = TextSpan(text: bigText.substring(1, bigText.length), style: _style.copyWith(color: Colors.white) );
    return Stack(children: [
        Positioned(
        left: MediaQuery.of(context).size.width * 0.5,
        child: CircleAvatar(
        radius: 200,
        backgroundColor: color.withOpacity(0.5),
      ),),
      Positioned(
        top: MediaQuery.of(context).size.height * 0.4,
        child: CircleAvatar(
        radius: 100,
        backgroundColor: Colors.white,
      ),),
      Positioned(
        top: 100, left: 80,
        child: Image.asset(
        imageAsset,
      )),
    
      CircleAvatar(
        radius: 50,
        backgroundColor: Colors.white,),
      CircleAvatar(
        radius: 80,
        backgroundColor: color.withOpacity(0.5),
      ),
       Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: RichText(
  text: TextSpan(
    style: DefaultTextStyle.of(context).style,
    children: <TextSpan>[
   _headText,
_bodyText
    ],
  ),
) )// _bodyText
    ],);
  }
}
