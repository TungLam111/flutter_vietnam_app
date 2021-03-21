import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/item.dart';
import 'package:flutter_vietnam_app/pages/home/home_screen/home_screen.dart';

class CloneBooking extends StatelessWidget {
  final Location location;
  const CloneBooking({this.location});

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
                    image: NetworkImage(location.images[0]),
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
        //height: MediaQuery.of(context).size.height - 110,
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
                          Text(location.name,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        //  mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(color: Colors.red[100]),
                              child: Text("Origin"), padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10)),
                              const SizedBox(height: 10.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Icon(Icons.add_a_photo_outlined),
                                SizedBox(width: 10),
                                Expanded(child: Text(location.origin),)
                              ],)
                          ]),
                          const SizedBox(
                        height: 10,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Container(
                              decoration: BoxDecoration(color: Colors.blue[100]),
                              child: Text("Voice"), padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10)),
                              const SizedBox(height: 10.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Icon(Icons.add_a_photo_outlined),
                                SizedBox(width: 10),
                                Expanded(child: Text(location.voice),)
                              ],)]),
                              const SizedBox(
                        height: 10,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Container(
                              decoration: BoxDecoration(color: Colors.green[100]),
                              child: Text("Description"), padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10)),
                              const SizedBox(height: 10.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Icon(Icons.add_a_photo_outlined),
                                SizedBox(width: 10),
                                Expanded(child: Text(location.description),)
                              ],)]),
                              const SizedBox(
                        height: 10,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Container(
                              decoration: BoxDecoration(color: Colors.orange[100]),
                              child: Text("Categories"), padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10)),
                              const SizedBox(height: 10.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Icon(Icons.add_a_photo_outlined),
                                SizedBox(width: 10),
                                Expanded(child: Wrap(
                                  direction: Axis.horizontal,
                                  children:location.categories.map((e){
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal:20,vertical:10),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Text(e,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),),
                                    );
                                  }).toList(),))
                              ],)]),
                              const SizedBox(
                        height: 10,
                      ),
                    
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Container(
                              decoration: BoxDecoration(color: Colors.yellow[100]),
                              child: Text("Related"), padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10)),
                              const SizedBox(height: 10.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Icon(Icons.add_a_photo_outlined),
                                SizedBox(width: 10),
                                Flexible(
                                  //padding: const EdgeInsets.all(10),
                                  //width: double.infinity,
                                  child:ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(5),
                                    itemCount: location.related.length,
                                    itemBuilder: (context,index){
                                      return GestureDetector(
                                        onTap:(){
                                          
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                padding: const EdgeInsets.symmetric(horizontal:20,vertical:10),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: Text(location.related[index],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15
                                                ),),
                                              ),
                                            SizedBox(height: 5),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                  
                                )
                                //Expanded(child: Text(location.related[0]),)
                              ],)])
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
