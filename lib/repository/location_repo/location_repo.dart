import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/models/user.dart';

abstract class LocationRepository {
  Future<UserModelList> getStreamUser(List<String> value);

  Future<List<Post>?> getStreamPost();

  Future<List<Post>?> getStreamPostFilter(
    String filter,
  );

  Future<String> addPost(Post post);

  Future<List<Post>?> getSuggestion(String suggestion);

  Stream<List<Location>?> getStreamSpeciality();

  Stream<List<Location>?> getStreamSpecialityByCategory(
    String filter,
  );

  Stream<List<Location>?> getStreamSpecialityByType(
    String filter,
  );

  Future<String> addLocation(
    Location location,
  );

  updateLocation(Location location);

  Stream<List<Comment>?> getStreamComment(String postId);

  Future<String> addComment(Comment comment);

  updateComment(Comment pet);
}
