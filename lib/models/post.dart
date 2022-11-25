import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:flutter_vietnam_app/models/user.dart';

class PostList {
  factory PostList.fromJson(List<dynamic> parsedJson) {
    List<Post> categories = parsedJson
        .map(
          (dynamic categoryJson) => Post.fromJSON(
            categoryJson as Map<String, dynamic>,
          ),
        )
        .toList();

    return PostList(
      categories: categories,
    );
  }

  factory PostList.fromFirebase(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> parsedJson,
  ) {
    List<Post> categories = parsedJson
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> categoryJson) =>
              Post.fromSnapshot(
            categoryJson,
          ),
        )
        .toList();

    return PostList(
      categories: categories,
    );
  }
  PostList({
    this.categories,
  });
  List<Post>? categories;
}

class Post {
  Post({
    this.subtitle,
    this.poster,
    this.content,
    this.title,
    this.postTime,
    this.images,
    this.countLike,
    this.countComment,
    this.reference,
    this.category,
    this.tags,
    this.posterModel,
  });

  factory Post.fromSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Post newPet = Post.fromJSON(snapshot.data());
    newPet.reference = snapshot.reference;
    return newPet;
  }

  // a factory constructor to create Location instance from json
  factory Post.fromJSON(Map<String, dynamic> json) {
    return factory.makeFromJson(json);
  }

  String? subtitle;
  String? poster;
  List<Map<String, dynamic>>? content;
  String? title;
  DateTime? postTime;
  List<String>? images;
  int? countLike;
  int? countComment;
  List<String>? category;
  List<String>? tags;
  UserModel? posterModel;

  DocumentReference? reference;
  static final PostFactory factory = PostFactory();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'subtitle': subtitle,
      'poster': poster,
      'content': content?.map((Map<String, dynamic> e) => e).toList(),
      'title': title,
      'count_like': countLike,
      'count_comment': countComment,
      'post_time': postTime?.toString(),
      'images': images?.map((String e) => e).toList(),
      'tags': tags?.map((String e) => e).toList(),
      'category': category?.map((String e) => e).toList(),
    };
  }

  setPosterModel(UserModel user) {
    posterModel = user;
  }
}

class PostFactory {
  Post makeFromJson(Map<String, dynamic> json) {
    return Post(
      subtitle: json['subtitle'] as String?,
      images: parseImages(json['images'] as List<dynamic>?),
      poster: json['poster'] as String?,
      postTime: parseDateJoined(json['post_time'] as String?),
      countLike: json['count_like'] as int?,
      countComment: json['count_comment'] as int?,
      content: parseContent(json['content'] as List<dynamic>?),
      title: json['title'] as String?,
      category: parseCategory(json['category'] as List<dynamic>?),
      tags: parseTags(json['tags'] as List<dynamic>?),
    );
  }

  List<Map<String, dynamic>>? parseContent(List<dynamic>? content) {
    if (content == null) return null;
    List<Map<String, dynamic>> categories = content
        .map(
          (dynamic categoryJson) => Map<String, dynamic>.from(
            categoryJson as Map<String, dynamic>,
          ),
        )
        .toList();
    return categories;
  }

  List<String>? parseImages(List<dynamic>? images) {
    if (images == null) return null;
    List<String> categories =
        images.map((dynamic categoryJson) => categoryJson.toString()).toList();
    return categories;
  }

  List<String>? parseTags(List<dynamic>? tags) {
    if (tags == null) return null;
    List<String> categories =
        tags.map((dynamic categoryJson) => categoryJson.toString()).toList();
    return categories;
  }

  List<String>? parseCategory(List<dynamic>? tags) {
    if (tags == null) return null;
    List<String> categories =
        tags.map((dynamic categoryJson) => categoryJson.toString()).toList();
    return categories;
  }

  DateTime? parseDateJoined(String? dateJoined) {
    if (dateJoined == null) return null;
    return DateTime.parse(dateJoined).toLocal();
  }

  CommentList? parseComments(List<dynamic>? comments) {
    if (comments == null) return null;
    return CommentList.fromJson(comments);
  }
}
