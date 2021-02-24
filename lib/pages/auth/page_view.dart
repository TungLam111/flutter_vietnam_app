import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(
    home: PageViewAnother(),
  ));
}
class PageViewAnother extends StatelessWidget {
  final PageController ctrl=PageController(initialPage: 0,keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
      controller: ctrl,
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Spacer(),
                    Image.asset('assets/images/tranh_dong_ho_sqr.jpg',width: MediaQuery.of(context).size.width-30,)
                  ],
                ),
                SizedBox(height: 20,),
                Text('Ứng dụng VinTravel',style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Ứng dụng giới thiệu các cảnh đẹp, món ăn, trang phục Việt Nam',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),),
                )
              ],)
          ),
          bottomSheet: Row(
        children: [
          TextButton(onPressed: (){
            //Chuyển trang
          }, child: Text('SKIP')),
          Spacer(),
          TextButton(onPressed: (){
            bool check=false;
            if(ctrl.page==0){
              ctrl.jumpToPage(1);
              check=true;
            }
            if(ctrl.page==1&&check==false)
              ctrl.jumpToPage(2);
          }, child: Text('NEXT'))
        ],
      ), 
        ),
        Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Spacer(),
                    Image.asset('assets/images/com_lang_vong_sqr.jpg',width: MediaQuery.of(context).size.width-30,),
                  ],
                ),
                SizedBox(height: 20,),
                Text('Second',style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                //SizedBox(height:20,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ultricies ultrices diam, in laoreet velit scelerisque sed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),),
                )
              ],
            ),
          ),
          bottomSheet: Row(
        children: [
          TextButton(onPressed: (){
            //Chuyển trang
          }, child: Text('SKIP')),
          Spacer(),
          TextButton(onPressed: (){
            bool check=false;
            if(ctrl.page==0){
              ctrl.jumpToPage(1);
              check=true;
            }
            if(ctrl.page==1&&check==false)
              ctrl.jumpToPage(2);
          }, child: Text('NEXT'))
        ],
      )
        ),
        Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Spacer(),
                    Image.asset('assets/images/huong_dinh_sqr.jpg',width: MediaQuery.of(context).size.width-30,),
                  ],
                ),
                SizedBox(height: 20,),
                Text('Third',style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                //SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ultricies ultrices diam, in laoreet velit scelerisque sed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),),
                )
              ],
            ),
          ),
          bottomSheet: Row(
        children: [
          Spacer(),
          TextButton(onPressed: (){
            //OK
          }, child: Text('DONE'))
        ],
      )
        ),
      ],
    ),
        
    );
  }
}