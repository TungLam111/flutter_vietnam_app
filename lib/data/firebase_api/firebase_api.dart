import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/models/post.dart';

abstract class FirebaseApi {
  Future<User?> loginWithFirebase({
    required String email,
    required String password,
  });

  Future<User?> signupWithFirebase({
    required String email,
    required String password,
  });

  Future<User?> getCurrentUserWithFirebase();

  Future<QuerySnapshot<Map<String, dynamic>>> getStreamUser(List<String> value);

  Future<QuerySnapshot<Map<String, dynamic>>> getStreamPost();

  Future<QuerySnapshot<Map<String, dynamic>>> getStreamPostFilter(
    String filter,
  );

  Future<DocumentReference<Map<String, dynamic>>> addPost(Post post);

  Future<QuerySnapshot<Map<String, dynamic>>> getSuggestion(String suggestion);

  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamSpeciality();

  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamSpecialityByCategory(
    String filter,
  );

  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamSpecialityByType(
    String filter,
  );

  Future<DocumentReference<Map<String, dynamic>>> addLocation(
    Location location,
  );

  updateLocation(Location location);

  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamComment(String postId);

  Future<DocumentReference<Map<String, dynamic>>> addComment(Comment comment);

  updateComment(Comment pet);
}
