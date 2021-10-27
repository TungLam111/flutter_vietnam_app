import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/services/data_repository/repository.dart';


class DataRepository implements Repository {
  final CollectionReference collectionLocation = Firestore.instance.collection('speciality');
  final CollectionReference collectionComment = Firestore.instance.collection('comment');
  final CollectionReference collectionPost = Firestore.instance.collection('post');
  final CollectionReference collectionUser = Firestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  Future<FirebaseUser> loginWithFirebase({String email ,String password})async{
    return (await auth.signInWithEmailAndPassword(
              email: email, password: password)).user;
  }

  Future<FirebaseUser> signupWithFirebase({String email ,String password})async{
    return (await auth.createUserWithEmailAndPassword(
              email: email, password: password)).user;
  }

  Future<FirebaseUser> getCurrentUserWithFirebase(){
    return auth.currentUser();
  }

  Stream<QuerySnapshot> getStreamUser(String value) {
    return collectionUser.where('email', isEqualTo: value ).snapshots();
  }
  
  Stream<QuerySnapshot> getStreamPost() {
    return collectionPost.snapshots();
  }

  Stream<QuerySnapshot> getStreamPostFilter(String filter) {
    return collectionPost.where("category",arrayContains: filter).snapshots();
  }
  
  Future<DocumentReference> addPost(Post post) {
    return collectionPost.add(post.toJson());
  }

  Stream<QuerySnapshot> getSuggestion(String suggestion) {
   return Firestore.instance.collection('post')
      .orderBy('title')
      .startAt([suggestion])
      .endAt([suggestion + '\uf8ff']).snapshots();
  }
  
  Stream<QuerySnapshot> getStreamSpeciality() {
    return collectionLocation.snapshots();
  }

  Stream<QuerySnapshot> getStreamSpecialityByCategory(String filter){
    return collectionLocation.where("categories",arrayContains: filter).snapshots();
  }

  Stream<QuerySnapshot> getStreamSpecialityByType(String filter){
    return collectionLocation.where("type_dish", arrayContains: filter).snapshots();
  }

  Future<DocumentReference> addLocation(Location location) {
    return collectionLocation.add(location.toJson());
  }

  updateLocation(Location location) async {
      await collectionLocation.document(location.reference.documentID).updateData(location.toJson());
  }

  Stream<QuerySnapshot> getStreamComment() {
    return collectionComment.snapshots();
  }

   Future<DocumentReference> addComment(Comment comment) {
    return collectionComment.add(comment.toJson());
  }

   updateComment(Comment pet) async {
      await collectionComment.document(pet.reference.documentID).updateData(pet.toJson());
  }
}