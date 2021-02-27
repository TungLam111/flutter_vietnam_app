import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home:Description(),
  ));
}
class Description extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageView(
        children: [
          NewWidget(),
            Container(
              child:Column(
                children: [
                  Image.asset('assets/images/img1_2.jpg',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height/3,),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 5,),
                        Text('Quảng Nam',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(height:10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.account_balance),
                        SizedBox(width: 5,),
                        Text('Destination',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),)
                      ]
                    ),
                  ),
                  SizedBox(height:10),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left:10),
                    child: Text('Phố cổ Hội An', 
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                        )),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left:10,right:10),
                    child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore,et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                  SizedBox(height:20),
                  Container(
                    //padding: EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width-20,
                    decoration: BoxDecoration(
                        border: Border.all(width:2),
                        borderRadius: BorderRadius.circular(20),
                        color:Colors.grey,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width:MediaQuery.of(context).size.width/2-10,
                          padding: EdgeInsets.only(top:10,bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width:2),
                            borderRadius: BorderRadius.circular(20),
                            color:Colors.white,
                          ),
                          child: Center(
                            child: Text('Images',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          )),
                          ),
                        ),
                        Container(
                          width:MediaQuery.of(context).size.width/2-20,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            //border: Border.all(width:0),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                            color:Colors.grey,
                          ),
                          child: Center(
                            child: Text('Related',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          )),
                          ),
                        )
                      ],
                    ),
                  ),
                  
                  
                ],
              )
            ),
        ],
        scrollDirection: Axis.vertical,
      ),

    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      decoration: BoxDecoration(
      image:DecorationImage(
        image:AssetImage('assets/images/img1_2.jpg'),
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
        stops: [0.2, 1],
        end: Alignment.bottomCenter,
        ),
      ),
      child:Padding(
        padding: EdgeInsets.only(left:10),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                SizedBox(height:30),
                CircleAvatar(
                  child: IconButton(
                  icon:Icon(Icons.arrow_back),
                  onPressed: (){},
                  ),
                ),
                Spacer(),
                Text('Phố cổ Hội An',
                style:TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize:30,
                )),
                SizedBox(height: 10,),
                Text('Tỉnh Quảng Nam',
                style:TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize:15,
                )),
                SizedBox(height: 10,),
                Text('Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...',
                style:TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize:15,
                )),
                SizedBox(height: 10,),
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
      )),
    );
  }
}