import 'package:flutter/material.dart';
import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class CloneBooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_buildAppBar(context), _buildCard(context)],
    );
  }

  Widget _buildAppBar(BuildContext context) => new Scaffold(
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/img1_2.jpg"),
                    fit: BoxFit.cover)),
          ),
          Opacity(
            opacity: 0.8,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.green),
          )
        ]),
      );
  Widget _buildCard(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height - 110,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 0.5))
            ]),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Che Khuc Bach",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25))
                        ],
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/food/1.png',
                          height: 250,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text("Origin")]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text("Voice")]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text("Description")]),
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text("Categories")]),
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text("Description")])
                    ],
                  ),
                ))));
  }
}

class ShowName extends StatelessWidget {
  final String pathImage;
  final String name;
  final String age;
  final String gender;
  final String seatName;
  ShowName({this.pathImage, this.name, this.age, this.gender, this.seatName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(pathImage),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(
              height: 8,
            ),
            Text('$age, $gender',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey,
                ))
          ],
        ),
        Spacer(),
        Card(
          color: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.airline_seat_recline_extra_rounded, size: 15),
                SizedBox(
                  width: 5,
                ),
                Text('$seatName',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //color:Colors.grey,
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
