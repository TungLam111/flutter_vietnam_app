import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'pets.dart';


class DataRepository {
  final CollectionReference collection = Firestore.instance.collection('pets');
  final CollectionReference collectionLocation = Firestore.instance.collection('speciality');
  final CollectionReference collectionComment = Firestore.instance.collection('comment');
  final CollectionReference collectionDestination = Firestore.instance.collection('destination');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  
  Stream<QuerySnapshot> getStreamSpeciality() {
    return collectionLocation.snapshots();
  }

  Future<DocumentReference> addPet(Pet pet) {
    return collection.add(pet.toJson());
  }

  Future<DocumentReference> addLocation(Location location) {
    return collectionLocation.add(location.toJson());
  }

  updatePet(Pet pet) async {
      await collection.document(pet.reference.documentID).updateData(pet.toJson());
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