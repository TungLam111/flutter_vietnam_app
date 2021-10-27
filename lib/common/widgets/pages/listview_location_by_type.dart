import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vietnam_app/services/data_repository/data_repo.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'page_product.dart';

class ListViewLocationByType  extends StatefulWidget {
  final String filter;
  const ListViewLocationByType({this.filter});

   @override
  _ListViewLocationByTypeState createState() => _ListViewLocationByTypeState();
}

class _ListViewLocationByTypeState extends State<ListViewLocationByType> {
  final DataRepository repository = DataRepository();
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getStreamSpecialityByType(widget.filter),
        builder: (context, snapshot) {
             if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
             List<DocumentSnapshot> snapshotDataDocument = snapshot.data.documents;
          return Stack(
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 15),
                color: Colors.white,
                child: Row(children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios_rounded)),
                  SizedBox(width: 50),
                  Text(widget.filter, style: TextStyle(fontWeight: FontWeight.bold))
                ],)
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: AnimationLimiter(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: snapshotDataDocument.length,
        itemBuilder: (BuildContext context, int index) {
              Location location = Location.fromSnapshot(snapshotDataDocument[index]);
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: YourListChild(location),
                  ),
                ),
              );
        },
      ),
    ),
              ),
            ],
          );
        }
      ),
    );
  }
}

class YourListChild extends StatelessWidget {
  final Location location;
  YourListChild(this.location);
  @override 
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DescriptionProduct(location: location)),
      );
      },
          child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Stack(children: [
          Image.network(location.images[0].toString()),
       Container( 
         margin: EdgeInsets.only(left: 10, top: 10, right: 10),
              color: Colors.black.withOpacity(0.7),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(location.name, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),)
            ),
          
        ],),
      ),
    );
  }
}