import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'pets.dart';


class DataRepository {
  final CollectionReference collection = Firestore.instance.collection('pets');
  final CollectionReference collectionLocation = Firestore.instance.collection('speciality');
  final CollectionReference collectionComment = Firestore.instance.collection('comment');
  //final CollectionReference collectionDestination = Firestore.instance.collection('destination');
  final CollectionReference collectionPost = Firestore.instance.collection('post');
  final CollectionReference collectionUser = Firestore.instance.collection('users');
  
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

  updatePost(Pet post) async {
      await collectionPost.document(post.reference.documentID).updateData(post.toJson());
  }


  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  

  Future<DocumentReference> addPet(Pet pet) {
    return collection.add(pet.toJson());
  }

  updatePet(Pet pet) async {
      await collection.document(pet.reference.documentID).updateData(pet.toJson());
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