import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/models/user.dart';
import 'package:flutter_vietnam_app/repository/location_repo/location_repo.dart';
import 'package:flutter_vietnam_app/services/location/location_service.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl(this._locationService);
  final LocationService _locationService;

  // firebase
  @override
  Future<String> addComment(Comment comment) async {
    DocumentReference<Map<String, dynamic>> stream =
        await _locationService.addComment(comment);
    return stream.id;
  }

  @override
  Future<String> addLocation(Location location) async {
    DocumentReference<Map<String, dynamic>> stream =
        await _locationService.addLocation(location);
    return stream.id;
  }

  @override
  Future<String> addPost(Post post) async {
    DocumentReference<Map<String, dynamic>> stream =
        await _locationService.addPost(post);
    return stream.id;
  }

  @override
  Stream<List<Comment>?> getStreamComment(String postId) async* {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        _locationService.getStreamComment(postId);
    Stream<List<Comment>?> newStream = stream.asyncMap(
      (QuerySnapshot<Map<String, dynamic>> event) =>
          CommentList.fromFirebase(event.docs).categories,
    );
    yield* newStream;
  }

  @override
  Future<List<Post>?> getStreamPost() async {
    QuerySnapshot<Map<String, dynamic>> response =
        await _locationService.getStreamPost();
    List<Post>? listData = PostList.fromFirebase(response.docs).categories;
    if (listData == null) {
      return null;
    }
    UserModelList listUserByPost = await getStreamUser(
      listData.map((Post e) => e.poster.toString()).toList(),
    );

    return listData
        .map(
          (Post e) =>
              e..posterModel = listUserByPost.getPosterOfPost(e.poster!),
        )
        .toList();
  }

  @override
  Future<List<Post>?> getStreamPostFilter(String filter) async {
    QuerySnapshot<Map<String, dynamic>> response =
        await _locationService.getStreamPostFilter(filter);
    List<Post>? listData = PostList.fromFirebase(response.docs).categories;
    if (listData == null) {
      return null;
    }
    UserModelList listUserByPost = await getStreamUser(
      listData.map((Post e) => e.poster.toString()).toList(),
    );

    return listData
        .map(
          (Post e) =>
              e..posterModel = listUserByPost.getPosterOfPost(e.poster!),
        )
        .toList();
  }

  @override
  Stream<List<Location>?> getStreamSpeciality() async* {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        _locationService.getStreamSpeciality();
    Stream<List<Location>?> newStream = stream.asyncMap(
      (QuerySnapshot<Map<String, dynamic>> event) =>
          LocationList.fromFirebase(event.docs).categories,
    );
    yield* newStream;
  }

  @override
  Stream<List<Location>?> getStreamSpecialityByCategory(String filter) async* {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        _locationService.getStreamSpecialityByCategory(filter);
    Stream<List<Location>?> newStream = stream.asyncMap(
      (QuerySnapshot<Map<String, dynamic>> event) =>
          LocationList.fromFirebase(event.docs).categories,
    );
    yield* newStream;
  }

  @override
  Stream<List<Location>?> getStreamSpecialityByType(String filter) async* {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        _locationService.getStreamSpecialityByType(filter);
    Stream<List<Location>?> newStream = stream.asyncMap(
      (QuerySnapshot<Map<String, dynamic>> event) =>
          LocationList.fromFirebase(event.docs).categories,
    );
    yield* newStream;
  }

  @override
  Future<UserModelList> getStreamUser(List<String> value) async {
    QuerySnapshot<Map<String, dynamic>> response =
        await _locationService.getStreamUser(value);

    return UserModelList.fromFirebase(response.docs);
  }

  @override
  Future<List<Post>?> getSuggestion(String suggestion) async {
    QuerySnapshot<Map<String, dynamic>> response =
        await _locationService.getSuggestion(suggestion);

    return PostList.fromFirebase(response.docs).categories;
  }

  @override
  updateComment(Comment pet) {
    _locationService.updateComment(pet);
  }

  @override
  updateLocation(Location location) {
    _locationService.updateLocation(location);
  }
}
