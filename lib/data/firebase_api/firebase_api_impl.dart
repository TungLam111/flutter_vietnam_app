import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vietnam_app/data/firebase_api/firebase_api.dart';
import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/models/post.dart';

class FirebaseApiImpl implements FirebaseApi {
  FirebaseApiImpl(this._firestoreInstance, this._firebaseAuth);

  final FirebaseFirestore _firestoreInstance;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<User?> loginWithFirebase({
    required String email,
    required String password,
  }) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
  }

  @override
  Future<User?> signupWithFirebase({
    required String email,
    required String password,
  }) async {
    return (await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
  }

  @override
  Future<User?> getCurrentUserWithFirebase() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getStreamUser(
    List<String> value,
  ) {
    return _firestoreInstance
        .collection('users')
        .where('email', whereIn: value)
        .get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getStreamPost() {
    return _firestoreInstance.collection('post').get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getStreamPostFilter(
    String filter,
  ) {
    return _firestoreInstance
        .collection('post')
        .where('category', arrayContains: filter)
        .get();
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> addPost(Post post) {
    return _firestoreInstance.collection('post').add(post.toJson());
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getSuggestion(String suggestion) {
    return _firestoreInstance.collection('post').orderBy('title').startAt(
      <String>[suggestion],
    ).endAt(
      <String>['$suggestion\uf8ff'],
    ).get();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamSpeciality() {
    return _firestoreInstance.collection('speciality').snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamSpecialityByCategory(
    String filter,
  ) {
    return _firestoreInstance
        .collection('speciality')
        .where('categories', arrayContains: filter)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamSpecialityByType(
    String filter,
  ) {
    return _firestoreInstance
        .collection('speciality')
        .where('type_dish', arrayContains: filter)
        .snapshots();
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> addLocation(
    Location location,
  ) {
    return _firestoreInstance.collection('speciality').add(location.toJson());
  }

  @override
  updateLocation(Location location) async {
    await _firestoreInstance
        .collection('speciality')
        .doc(location.reference?.id)
        .update(location.toJson());
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamComment(String postId) {
    return _firestoreInstance
        .collection('comment')
        .where('location', isEqualTo: postId)
        .snapshots();
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> addComment(Comment comment) {
    return _firestoreInstance.collection('comment').add(comment.toJson());
  }

  @override
  updateComment(Comment pet) async {
    await _firestoreInstance
        .collection('comment')
        .doc(pet.reference!.id)
        .update(pet.toJson());
  }
}
