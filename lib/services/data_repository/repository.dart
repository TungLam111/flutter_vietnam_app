

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/models/post.dart';

abstract class Repository {
  Future<FirebaseUser> loginWithFirebase({String email ,String password});

  Future<FirebaseUser> signupWithFirebase({String email ,String password});
  
  Future<FirebaseUser> getCurrentUserWithFirebase();
  
  Stream<QuerySnapshot> getStreamUser(String value);

  Stream<QuerySnapshot> getStreamPost();

  Stream<QuerySnapshot> getStreamPostFilter(String filter);

  Future<DocumentReference> addPost(Post post);

  Stream<QuerySnapshot> getSuggestion(String suggestion);

  Stream<QuerySnapshot> getStreamSpeciality();

  Stream<QuerySnapshot> getStreamSpecialityByCategory(String filter);

  Stream<QuerySnapshot> getStreamSpecialityByType(String filter);

  Future<DocumentReference> addLocation(Location location);

  updateLocation(Location location);

  Stream<QuerySnapshot> getStreamComment();

   Future<DocumentReference> addComment(Comment comment);
   
   updateComment(Comment pet);
}