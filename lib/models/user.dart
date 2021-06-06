import 'package:dcache/dcache.dart';
import 'package:flutter_vietnam_app/models/updateable_model.dart';
class User extends UpdatableModel<User> {

   String displayName;
   String email;
   String phoneNumber;
   String photoUrl;

   User({ this.displayName,this.email, this.phoneNumber, this.photoUrl});
   
     static final navigationUsersFactory = UserFactory(
      cache:
          LfuCache<int, User>(storage: UpdatableModelSimpleStorage(size: 100)));

  factory User.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return navigationUsersFactory.makeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'phoneNumber' : phoneNumber,
      'photoUrl' : photoUrl,
      'email' : email 
    };
  }

  void updateFromJson(Map json) {
    if (json.containsKey('displayName')) displayName = json['displayName'];
    if (json.containsKey('phoneNumber')) phoneNumber = json['phoneNumber'];
    if (json.containsKey('photoUrl')) photoUrl = json['photoUrl'];
    if (json.containsKey('email')) email = json['email'];
  }

}


class UserFactory extends UpdatableModelFactory<User> {
  UserFactory({cache}) : super(cache: cache);

  @override
  User makeFromJson(Map json) {
    return User(
        displayName: json['displayName'],
        phoneNumber: json['phoneNumber'],
        photoUrl: json['photoUrl'],
        email: json['email']
    );
  }
}