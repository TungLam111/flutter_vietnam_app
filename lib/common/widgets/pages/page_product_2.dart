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
        _buildCard(context)
      ],
    );
  }
  Widget _buildAppBar() => new Scaffold(
    body: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/img1_2.jpg"), fit: BoxFit.cover)),)
  );
  Widget _buildCard(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        height: MediaQuery.of(context).size.height-110,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              offset: Offset(0.0, 0.5)
            )
          ]
        ),
        child: GradientCard(
          gradient: Gradients.buildGradient(
           Alignment.topCenter,
           Alignment.bottomCenter,
           [Colors.green[900],Colors.green[600],Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white,Colors.white],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child:Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
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
          
           
          
    
                  
              
              ],
            ),)
          )
        )
      
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