import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_vietnam_app/models/updateable_model.dart';
import 'package:dcache/dcache.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentList{
  final List<Comment> comments;
  CommentList({
    this.comments
  });
   factory CommentList.fromJson(List<dynamic> parsedJson) {
    List<Comment> comments = parsedJson
        .map((categoryJson) => Comment.fromJSON(categoryJson))
        .toList();

    return new CommentList(
      comments: comments,
    );
  }
}
class Comment extends UpdatableModel<Comment> {
  String sender;
  String comment;
  int rating;
  List<String> images;
  DateTime time;
  String location;
  
  DocumentReference reference;
  Comment({
    this.sender,
    this.comment,
    this.rating,
    this.time,
    this.images,
    this.location,
    this.reference
  });
  
  static final factory = CommentFactory();

  factory Comment.fromJSON(Map<String, dynamic> json) {
    if (json == null) return null;
    return factory.makeFromJson(json);
    // return Comment(
    //   sender: json['sender'],
    //   comment: json['comment'],
    //   rating: json['rating'],
    //   time: json['time'],
    //   images: json['images'],
    //   location: json['location']
    // );
  }
  // a factory constructor to create a Location from a Firestore DocumentSnapshot
  factory Comment.fromSnapshot(DocumentSnapshot snapshot) {
    Comment newPet = Comment.fromJSON(snapshot.data);
    newPet.reference = snapshot.reference;
    return newPet;
  }

  Map<String, dynamic> toJson() {
    return {
    "sender": sender ,
    "location": location ,
    "comment": comment ,
    "rating": rating ,
    "time": time?.toString(),
    "images": images?.map((String e) => e)?.toList() ,
    };
  }

  
  @override
  void updateFromJson(Map json) {
    
    // name o
    if (json.containsKey('sender')) {
      sender = json['sender'];
    }
    //address of that destination
    if (json.containsKey('location')) {
      location = json['location'];
    }
    //district 
    if (json.containsKey('comment')) {
      comment = json['comment'];
    }

    if (json.containsKey('rating')) {
      rating = json['rating'];
    }

    if (json.containsKey('time')) {
      time = factory.parseDateJoined(json['time']);
    }
    // list images about that destination
    if (json.containsKey('images')) {
      images = factory.parseImages(json['images']);
    }
  
    
  }
}

class CommentFactory extends UpdatableModelFactory<Comment> {
  @override
  SimpleCache<int, Comment> cache =
      SimpleCache(storage: UpdatableModelSimpleStorage(size: 20));

  @override
  Comment makeFromJson(Map json) {
    return Comment(
      sender: json['sender'],
      location: json['location'],
      comment: json['comment'],
      time: parseDateJoined(json['time']),
      rating: json['functionalities'],
      images: parseImages(json['images']),
    );
  }

  List<String> parseImages(List images){
    if (images == null) return null;
    List<String> categories = images
        .map((categoryJson) => categoryJson.toString())
        .toList();
    return categories;
  }
  
  DateTime parseDateJoined(String dateJoined) {
    if (dateJoined == null) return null;
    return DateTime.parse(dateJoined).toLocal();
  }

}