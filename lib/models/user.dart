import 'package:cloud_firestore/cloud_firestore.dart';

class UserModelList {
  factory UserModelList.fromFirebase(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> parsedJson,
  ) {
    List<UserModel> categories = parsedJson
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> categoryJson) =>
              UserModel.fromFirebase(
            categoryJson,
          ),
        )
        .toList();

    return UserModelList(
      categories: categories,
    );
  }

  factory UserModelList.fromJson(List<dynamic> parsedJson) {
    List<UserModel> categories = parsedJson
        .map(
          (dynamic categoryJson) => UserModel.fromJson(
            categoryJson as Map<String, dynamic>,
          ),
        )
        .toList();

    return UserModelList(
      categories: categories,
    );
  }
  UserModelList({
    this.categories,
  });

  UserModel? getPosterOfPost(String poster) {
    for (UserModel user in categories ?? <UserModel>[]) {
      if (user.email == poster) {
        return user;
      }
    }
    return null;
  }

  List<UserModel>? categories;
}

class UserModel {
  factory UserModel.fromFirebase(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return UserModel.fromJson(snapshot.data());
  }
  UserModel({
    this.id,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoUrl,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return userFactory.makeFromJson(json);
  }
  String? id;
  String? displayName;
  String? email;
  String? phoneNumber;
  String? photoUrl;

  static final UserFactory userFactory = UserFactory();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'email': email
    };
  }
}

class UserFactory {
  UserModel makeFromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      displayName: json['displayName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoUrl: json['photoUrl'] as String?,
      email: json['email'] as String?,
    );
  }
}
