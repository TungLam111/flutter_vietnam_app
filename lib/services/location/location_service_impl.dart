import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vietnam_app/data/firebase_api/firebase_api.dart';
import 'package:flutter_vietnam_app/data/web_httpie/httpie.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:flutter_vietnam_app/services/location/location_service.dart';

class LocationServiceImpl implements LocationService {
  LocationServiceImpl(this._httpService, this._firebaseApi);
  final Httpie _httpService;
  final FirebaseApi _firebaseApi;
  static const String apiURL = 'https://shielded-depths-44788.herokuapp.com/';
  static const String getAllLocationEndpoint = 'speciality/ReadAllSpeciality';
  static const String getLocationByNameEndpoint = 'speciality/ReadSpeciality';
  static const String getLocationsByListEndpoint =
      'speciality/ReadListSpecialityByListName';
  static const String getLocationsByCategoryEndpoint =
      'speciality/ReadListSpecialityByCategories';

  @override
  Future<HttpieResponse> getAllLocations() {
    return _httpService.postJSON(
      '$apiURL$getAllLocationEndpoint',
      appendAuthorizationToken: true,
    );
  }

  @override
  Future<HttpieResponse> getLocationByName({required String locationName}) {
    Map<String, dynamic> body = <String, dynamic>{'name': locationName};
    return _httpService.post(
      '$apiURL$getLocationByNameEndpoint',
      body: body,
      appendAuthorizationToken: true,
    );
  }

  @override
  Future<HttpieResponse> getLocationsByList(List<String> listLocation) {
    Map<String, dynamic> body = <String, dynamic>{'name': listLocation};
    return _httpService.postJSON(
      '$apiURL$getLocationsByListEndpoint',
      body: body,
      appendAuthorizationToken: true,
    );
  }

  @override
  Future<HttpieResponse> getLocationsByCategory({String? category}) {
    Map<String, dynamic> body = <String, dynamic>{'categories': category};

    return _httpService.postJSON(
      '$apiURL$getLocationsByCategoryEndpoint',
      body: body,
      appendAuthorizationToken: true,
    );
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> addComment(Comment comment) {
    return _firebaseApi.addComment(comment);
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> addLocation(
    Location location,
  ) {
    return _firebaseApi.addLocation(location);
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> addPost(Post post) {
    return _firebaseApi.addPost(post);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamComment(String postId) {
    return _firebaseApi.getStreamComment(postId);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getStreamPost() {
    return _firebaseApi.getStreamPost();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getStreamPostFilter(
    String filter,
  ) {
    return _firebaseApi.getStreamPostFilter(filter);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamSpeciality() {
    return _firebaseApi.getStreamSpeciality();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamSpecialityByCategory(
    String filter,
  ) {
    return _firebaseApi.getStreamSpecialityByCategory(filter);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamSpecialityByType(
    String filter,
  ) {
    return _firebaseApi.getStreamSpecialityByType(filter);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getStreamUser(
    List<String> value,
  ) {
    return _firebaseApi.getStreamUser(value);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getSuggestion(String suggestion) {
    return _firebaseApi.getSuggestion(suggestion);
  }

  @override
  updateComment(Comment pet) {
    _firebaseApi.updateComment(pet);
  }

  @override
  updateLocation(Location location) {
    _firebaseApi.updateLocation(location);
  }
}
