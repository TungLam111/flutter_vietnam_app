import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/services/data_repository/data_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_vietnam_app/pages/home/home_screen/post_page.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({this.post});

  @override
  Widget build(BuildContext context) {
    final DataRepository repository = DataRepository();
    //  var data = _firestore.collection("users").where('email', isEqualTo: post.poster );
    return StreamBuilder<QuerySnapshot>(
        stream: repository.getStreamUser(post.poster),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          List<DocumentSnapshot> users = snapshot.data.documents;
          DocumentSnapshot user = users[0];

          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostPage(post: post)),
                );
                // _firestore.collection("users").document(loggedInUser.uid).setData({"displayName": "tunglamahihi", "phoneNumber": "0829976232", "photoUrl": "https://cdn.ibispaint.com/movie/728/965/728965653/image728965653.png"});
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          user["photoUrl"].toString())),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    width: 150,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ( post.category != null && post.category.length > 0 ) ? Text("${post.category[0]}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )) : SizedBox(),
                                        Text("@${user["displayName"]}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              post.postTime != null ?Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(post.postTime),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic)) : SizedBox()
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image.network(
                            "${post.images[0]}",
                            fit: BoxFit.fitWidth,
                            width: 400,
                            height: 200,
                          ),
                          Text("${post.title}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25)),
                          post.tags != null ? Wrap(
                            
                            children: post.tags.map((e) {
                              return Container(
                                child: Text("#${e.toString()}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic)),
                                decoration:
                                    BoxDecoration(color: Colors.blueGrey),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                margin: EdgeInsets.only(left: 10, bottom: 5),
                              );
                            }).toList(),
                          ) : SizedBox()
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
