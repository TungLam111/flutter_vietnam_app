import 'package:dcache/dcache.dart';
import 'package:flutter_vietnam_app/models/updateable_model.dart';
class User extends UpdatableModel<User> {
   int id;
   String uuid;
   String username;
   String phonenumber;
   String email;
  User({this.id,  this.email,this.uuid, this.username,this.phonenumber});
   
     static final navigationUsersFactory = UserFactory(
      cache:
          LfuCache<int, User>(storage: UpdatableModelSimpleStorage(size: 100)));
  static final sessionUsersFactory = UserFactory(
      cache: SimpleCache<int, User>(
          storage: UpdatableModelSimpleStorage(size: 10)));

  static final maxSessionUsersFactory = UserFactory(
      cache: SimpleCache<int, User>(
          storage: UpdatableModelSimpleStorage(
              size: UpdatableModelSimpleStorage.MAX_INT)));

  factory User.fromJson(Map<String, dynamic> json,
      {bool storeInSessionCache = false, bool storeInMaxSessionCache = false}) {
    if (json == null) return null;

    int userId = json['id'];

    User user = maxSessionUsersFactory.getItemWithIdFromCache(userId) ??
        navigationUsersFactory.getItemWithIdFromCache(userId) ??
        sessionUsersFactory.getItemWithIdFromCache(userId);
    if (user != null) {
      user.update(json);
      return user;
    }
    return storeInMaxSessionCache
        ? maxSessionUsersFactory.fromJson(json)
        : storeInSessionCache
            ? sessionUsersFactory.fromJson(json)
            : navigationUsersFactory.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'email': email,
      'username': username,
      'phonenumber' :phonenumber
    };
  }

  void updateFromJson(Map json) {
    if (json.containsKey('username')) username = json['username'];
    if (json.containsKey('uuid')) uuid = json['uuid'];
    if (json.containsKey('email')) uuid = json['email'];
    if (json.containsKey('phonenumber')) uuid = json['phonenumber'];
  }

}


class UserFactory extends UpdatableModelFactory<User> {
  UserFactory({cache}) : super(cache: cache);

  @override
  User makeFromJson(Map json) {
    return User(
        id: json['id'],
        uuid: json['uuid'],
        email: json['email'],
        username: json['username']
    );
  }
}

class UserVisibility {
  final String code;

  const UserVisibility._internal(this.code);

  toString() => code;

  static const public = const UserVisibility._internal('P');
  static const okuna = const UserVisibility._internal('O');
  static const private = const UserVisibility._internal('T');

  static const _values = const <UserVisibility>[
    public,
    okuna,
    private,
  ];

  static values() => _values;

  static UserVisibility parse(String string) {
    if (string == null) return null;

    UserVisibility userVisibility;
    for (var type in _values) {
      if (string == type.code) {
        userVisibility = type;
        break;
      }
    }

    if (userVisibility == null) {
      // Don't throw as we might introduce new notifications on the API which might not be yet in code
      print('Unsupported UserVisibility');
    }

    return userVisibility;
  }
}