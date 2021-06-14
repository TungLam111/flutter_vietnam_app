import 'package:dcache/dcache.dart';
import 'package:flutter_vietnam_app/models/updateable_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vietnam_app/models/comment.dart';

class PostList {
  final List<Post> categories;

 PostList({
    this.categories,
  });

  factory PostList.fromJson(List<dynamic> parsedJson) {
    List<Post> categories = parsedJson
        .map((categoryJson) => Post.fromJSON(categoryJson))
        .toList();

    return new PostList(
      categories: categories,
    );
  }
}
class Post extends UpdatableModel<Post>{
   String subtitle;
   String poster; 
   List<Map<String, dynamic>> content;
   String title;
   DateTime postTime;
   List<String> images;
   int countLike;
   int countComment;
   String category;
   List<String> tags;

   DocumentReference reference;

  Post({this.subtitle, this.poster,this.content, this.title, this.postTime, this.images, this.countLike, this.countComment, this.reference, this.category, this.tags});
    static final factory = PostFactory();
  
  // a factory constructor to create Location instance from json
  factory Post.fromJSON(Map<String, dynamic> json) {
    if (json == null) return null;
    return factory.makeFromJson(json);
  }
  
  // a factory constructor to create a Location from a Firestore DocumentSnapshot
  factory Post.fromSnapshot(DocumentSnapshot snapshot) {
    Post newPet = Post.fromJSON(snapshot.data);
    newPet.reference = snapshot.reference;
    return newPet;
  }

  Map<String, dynamic> toJson() {
    return {
      'subtitle' : subtitle,
      'poster': poster,
      'content': content?.map((Map e) => e)?.toList(),
      'title' : title,
      'count_like': countLike,
      'count_comment': countComment,
      "post_time": postTime?.toString(),
      'images': images?.map((String e) => e)?.toList(),
      'tags': tags.map((String e) => e)?.toList(),
      'category': category,
      //'comments': comments?.categories?.map((Comment comment) => comment.toJson())?.toList(),

    };
  }

  @override
  void updateFromJson(Map json) {

    if (json.containsKey('subtitle')) {
      subtitle = json['subtitle'];
    }

    if (json.containsKey('poster')) {
      poster = json['poster'];
    }

    if (json.containsKey('content')) {
      content = factory.parseContent(json['content']);
    }

    if (json.containsKey('title')) {
      title = json['title'];
    }

    if (json.containsKey('count_comment')) {
      countComment = json['count_comment'];
    }

    if (json.containsKey('count_like')) {
      countLike = json['count_like'];
    }

    if (json.containsKey('post_time')) {
      postTime = factory.parseDateJoined(json['post_time']);
    }

    if (json.containsKey('images')) {
      images = factory.parseImages(json['images']);
    }

    if (json.containsKey('category')) {
      category = json['category'];
    }

    if (json.containsKey('tags')) {
      tags = factory.parseTags(json['tags']);
    }
  }
}

class PostFactory extends UpdatableModelFactory<Post> {
  @override
  SimpleCache<int, Post> cache =
      SimpleCache(storage: UpdatableModelSimpleStorage(size: 20));

  @override
  Post makeFromJson(Map json) {
    return Post(
      subtitle: json['subtitle'],
      images: parseImages(json['images']),
      poster: json['poster'],
      postTime: parseDateJoined(json['post_time']),
      countLike: json['count_like'],
      countComment: json['count_comment'],
      content :parseContent(json['content']),
      title : json['title'],
      category: json['category'],
      tags: parseTags(json['tags']),
      
    );
  }
 
 List<Map<String, dynamic>> parseContent(List content){
    if (content == null) return null;
    List<Map<String, dynamic>> categories = content
        .map((categoryJson) => Map<String, dynamic>.from(categoryJson))
        .toList();
    return categories;
  }

  List<String> parseImages(List images){
    if (images == null) return null;
    List<String> categories = images
        .map((categoryJson) => categoryJson.toString())
        .toList();
    return categories;
  }

  List<String> parseTags(List tags){
    if (tags == null) return null;
    List<String> categories = tags
        .map((categoryJson) => categoryJson.toString())
        .toList();
    return categories;
  }

   DateTime parseDateJoined(String dateJoined) {
    if (dateJoined == null) return null;
    return DateTime.parse(dateJoined).toLocal();
  }

    CommentList parseComments(List comments) {
    if (comments == null) return null;
    return CommentList.fromJson(comments);
  }
}