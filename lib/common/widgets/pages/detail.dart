import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vietnam_app/services/data_repository/data_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'page_product.dart';
import 'listview_location_by_type.dart';

class Detail extends StatefulWidget {
  final Location location;
  const Detail({this.location});

   @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  
  int currentViewImage ;
  final DataRepository repository = DataRepository();
  @override 
  void initState(){
    super.initState();
    currentViewImage = 0;
  }


  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Container( 
        padding: EdgeInsets.symmetric(horizontal : 15.0, vertical: 20),
        child: SingleChildScrollView( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            Text(widget.location.name ?? "", style: TextStyle(fontSize: 30)),
            Text(widget.location.origin ?? "", style: TextStyle(fontSize:20)),

            Container(
              height: 150,
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: ListView(  
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                children: widget.location.images.map((e) => 
                GestureDetector(

                  onTap: () async {
              await showDialog(
                context: context,
                builder: (_) => ImageDialog(e)
              );
            },
                                  child: Container(
                    width: 120,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      image:  DecorationImage(image: NetworkImage("https://media.istockphoto.com/vectors/image-preview-icon-picture-placeholder-for-website-or-uiux-design-vector-id1222357475?k=6&m=1222357475&s=612x612&w=0&h=p8Qv0TLeMRxaES5FNfb09jK3QkJrttINH2ogIBXZg-c=")),
                     ),
                    child: Image.network(e.toString() ?? "https://media.istockphoto.com/vectors/image-preview-icon-picture-placeholder-for-website-or-uiux-design-vector-id1222357475?k=6&m=1222357475&s=612x612&w=0&h=p8Qv0TLeMRxaES5FNfb09jK3QkJrttINH2ogIBXZg-c=",  fit: BoxFit.cover)
                    
                  ),
                )
                 ).toList(),
              )
              ),
            Text(widget.location.subtitle ?? "SUBTITLE"),
            Column(
              children: widget.location.description.map((e) {
                if (e["type"] == "text") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(e["value"].toString()),
                  );
                }  
                else if (e["type"] == "image"){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(children: [
                      Image.network(e["value"].toString() ?? "https://lh3.googleusercontent.com/proxy/9dPYV4xRxWfbZXD31kRZI3e3b-12YqJ_CKzAoh96CFjVQnKi4CYlKpUF-QLs8EuQD_yse6yuykisV01e9zghMSJ77Dt3Dut2HAsVBpANRV_AaWrc14iQ3pHbyq7xMMDQXzZctFU"),
                      SizedBox(height: 5),
                      Text(e["title"] ?? "")
                    ],),
                  );
                }
                return SizedBox();
              }).toList()
            ),
            Divider(
              color: Colors.black
            ),
            Wrap(  
              
              children: widget.location.related.map((e) => 
              GestureDetector(
                onTap: (){

                },
                child: Container( 
                  margin: EdgeInsets.only(bottom: 10, left: 8),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child:
                    Text( "#" + e, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    
                  
                  decoration: BoxDecoration(
                    color: colorsList[widget.location.related.indexOf(e) % 5],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
              )
              ).toList(),
            ),
            Divider(
              color: Colors.black
            ),
            Text("You might have interest"),
                        Divider(
              color: Colors.black
            ),
            ListView.builder(  
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              itemCount: widget.location.typeDish.length,
              itemBuilder: (context, index){
                String filter = widget.location.typeDish[index];
                return StreamBuilder<QuerySnapshot>(
                  stream: repository.getStreamSpecialityByType(filter),
                  builder: (context, snapshot) {
                              if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
            List<DocumentSnapshot> snapshotDataDocument = snapshot.data.documents;

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                                  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListViewLocationByType(filter: filter)),
      );
                          },
                                                  child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(  
                                    borderRadius: BorderRadius.only(topLeft:Radius.circular(10), topRight: Radius.circular(10)),
                                  color: colorsList.last
                                  ),
                                                    child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                   padding: EdgeInsets.only(bottom: 10, top: 10 ),
                                  child: Text(widget.location.typeDish[index], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                                ),
                                Icon(Icons.arrow_forward, color: Colors.white, size: 25)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshotDataDocument.length > 5 ? 5 : snapshotDataDocument.length,
                            itemBuilder: (context, index){
                              Location location = Location.fromSnapshot(snapshotDataDocument[index]);
                              return LocationListTile(location);
                            },
                            
                          )
                        ),
                      ],
                    );
                  }
                );
              },
            )
          ],)
        )
      )
    );
  }
}

class LocationListTile extends StatelessWidget {
  final Location location;
  @override 
  LocationListTile(this.location);

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
        width: 150,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration( 
            border: Border.all(
                color: Colors.grey[200], width: 2
              ),
          borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(children: [
          Container( 
            width: 150,
            height: 130,
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15) , topRight: Radius.circular(15),),
              image: DecorationImage( image: NetworkImage(location.images[0], ), fit: BoxFit.cover)),
          ),
        
           Expanded(child: Text(location.name.toString(), style: TextStyle(fontWeight: FontWeight.bold)))
          
        ],)
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final String imgUrl;
  ImageDialog(this.imgUrl);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      
      child: Container(
        width: MediaQuery.of(context).size.width-20,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imgUrl),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }
}

const List<Color> colorsList = [Color(0xff292e32), Colors.grey, Color(0xff7aa0c4), Color(0xff34568f), Color(0xff2f425e)];