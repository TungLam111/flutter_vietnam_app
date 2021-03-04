import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class CloneBooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildAppBar(),
        Positioned(
          bottom: 10,
          child: _buildCard(context))
      ],
    );
  }
  Widget _buildAppBar() => new Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(150),
      child: AppBar(
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.arrow_back)
        ),
        title: Center(
          child: Text('BOARDING PASS',style:TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            fontSize: 15
          ),),
        ),
        backgroundColor: Color(0xff1954CF),
        actions:[
          IconButton(
          onPressed: (){},
          icon: Icon(Icons.vignette_rounded)
          ),
          SizedBox(width: 10,)
        ]
      ),
    )
  );
  Widget _buildCard(BuildContext context) {
    return Container(
      child: Container(
        height: MediaQuery.of(context).size.height-100,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75)
            )
          ]
        ),
        child:GradientCard(
          gradient: Gradients.buildGradient(
           Alignment.topCenter,
           Alignment.bottomCenter,
           [Color(0xff2f64d4),Color(0xff4d7cda),Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child:Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('24 Oct, 09:40',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight:FontWeight.w300,
                          color: Colors.grey
                        ),),
                        Text('LAS',
                        textAlign: TextAlign.left,
                        style:TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),),
                        Text('Las Vegas',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),)
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('11:10',style: TextStyle(
                          fontWeight:FontWeight.w300,
                          color: Colors.grey
                        ),),
                        Text('SFO',style:TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color:Colors.white
                        ),),
                        Text('San Fransico',style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:Colors.white
                        ),)
                      ],
                    )
                  ],
                ),
                Center(child: Image.asset('assets/images/aircraft.png'),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('Flight',style:TextStyle(
                          fontWeight: FontWeight.bold,
                          color:Colors.grey,
                        )),
                        SizedBox(height: 10,),
                        Text('LF714',style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:20
                        ))
                      ],
                    ),
                    Column(
                      children: [
                        Text('Class',style:TextStyle(
                          fontWeight: FontWeight.bold,
                          color:Colors.grey,
                        )),
                        SizedBox(height: 10,),
                        Text('First',style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:20
                        ))
                      ],
                    ),
                    Column(
                      children: [
                        Text('Boarding',style:TextStyle(
                          fontWeight: FontWeight.bold,
                          color:Colors.grey,
                        )),
                        SizedBox(height: 10,),
                        Text('09:10',style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:20
                        ))
                      ],
                    ),
                    Column(
                      children: [
                        Text('Terminal',style:TextStyle(
                          fontWeight: FontWeight.bold,
                          color:Colors.grey,
                        )),
                        SizedBox(height: 10,),
                        Text('12A',style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:20
                        ))
                      ],
                    )
                  ],
                ),
                //List of customers
                SizedBox(height: 20,),
                ShowName(
                  pathImage: 'assets/images/avt1.jpg',
                  name: 'Jeremy Russell',
                  age: '28y',
                  gender: 'Male',
                  seatName: '18A',
                ),
                SizedBox(height: 20,),
                ShowName(
                  pathImage: 'assets/images/avt8.jpg',
                  name: 'Maria Jenkins',
                  age: '24y',
                  gender: 'Female',
                  seatName: '18B',
                ),
                Spacer(),
                //Barcode
                BarcodeWidget(
                  height: 80,
                  width: MediaQuery.of(context).size.width-140,
                  barcode: Barcode.code128(),
                  data: 'H K L O 7 8 M P 8 9 2 S D',
                )
              ],
            ),
          )
        )
      ),
    );
  }
}

class ShowName extends StatelessWidget {
  final String pathImage;
  final String name;
  final String age;
  final String gender;
  final String seatName;
  ShowName({this.pathImage,this.name,this.age,this.gender,this.seatName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(pathImage),
        ),
        SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,style:TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            )),
            SizedBox(height: 8,),
            Text('$age, $gender',style:TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color:Colors.grey,
            ))
          ],
        ),
        Spacer(),
        Card(
          color: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Icon(Icons.airline_seat_recline_extra_rounded,size:15),
              SizedBox(width: 5,),
              Text('$seatName',style:TextStyle(
                fontWeight: FontWeight.bold,
                //color:Colors.grey,
              ))
            ],),
          ),
        ),
      ],
    );
  }
}