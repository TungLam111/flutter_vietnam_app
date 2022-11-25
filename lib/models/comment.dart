import 'package:cloud_firestore/cloud_firestore.dart';

class CommentList {
  CommentList({this.categories});
  factory CommentList.fromJson(List<dynamic> parsedJson) {
    List<Comment> categories = parsedJson
        .map(
          (dynamic categoryJson) => Comment.fromJSON(
            categoryJson as Map<String, dynamic>,
          ),
        )
        .toList();

    return CommentList(
      categories: categories,
    );
  }

  factory CommentList.fromFirebase(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> parsedJson,
  ) {
    List<Comment> categories = parsedJson
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> categoryJson) =>
              Comment.fromSnapshot(
            categoryJson,
          ),
        )
        .toList();

    return CommentList(
      categories: categories,
    );
  }

  final List<Comment>? categories;
}

class Comment {
  factory Comment.fromSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Comment newPet = Comment.fromJSON(snapshot.data());
    newPet.reference = snapshot.reference;
    return newPet;
  }

  factory Comment.fromJSON(Map<String, dynamic> json) {
    return factory.makeFromJson(json);
  }

  Comment({
    this.sender,
    this.comment,
    this.rating,
    this.time,
    this.images,
    this.location, // or location post
    this.reference,
    this.displayName,
    this.photoUrl,
  });
  String? sender;
  String? comment;
  double? rating; //rating of sender towards that locations
  List<String>? images;
  DateTime? time;
  String? location;
  String? photoUrl;
  String? displayName;

  DocumentReference? reference;

  static final CommentFactory factory = CommentFactory();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sender': sender,
      'location': location,
      'comment': comment,
      'rating': rating,
      'time': time?.toString(),
      'images': images?.map((String e) => e).toList(),
      'photoUrl': photoUrl,
      'displayName': displayName,
    };
  }
}

class CommentFactory {
  Comment makeFromJson(Map<String, dynamic> json) {
    return Comment(
      sender: json['sender'] as String?,
      photoUrl: json['photoUrl'] as String?,
      displayName: json['displayName'] as String?,
      location: json['location'] as String?,
      comment: json['comment'] as String?,
      time: parseDateJoined(json['time'] as String?),
      rating: json['rating'] == null
          ? null
          : double.parse(json['rating'].toString()),
      images: parseImages(json['images'] as List<dynamic>?),
    );
  }

  List<String>? parseImages(List<dynamic>? images) {
    if (images == null) return null;
    List<String> categories =
        images.map((dynamic categoryJson) => categoryJson.toString()).toList();
    return categories;
  }

  DateTime? parseDateJoined(String? dateJoined) {
    if (dateJoined == null) return null;
    return DateTime.parse(dateJoined).toLocal();
  }
}
