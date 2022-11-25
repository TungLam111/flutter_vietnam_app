import 'package:cloud_firestore/cloud_firestore.dart';

class LocationList {
  LocationList({
    this.categories,
  });

  factory LocationList.fromJson(List<dynamic> parsedJson) {
    List<Location> categories = parsedJson
        .map(
          (dynamic categoryJson) => Location.fromJSON(
            categoryJson as Map<String, dynamic>,
          ),
        )
        .toList();

    return LocationList(
      categories: categories,
    );
  }

  factory LocationList.fromFirebase(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> parsedJson,
  ) {
    List<Location> categories = parsedJson
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> categoryJson) =>
              Location.fromSnapshot(
            categoryJson,
          ),
        )
        .toList();

    return LocationList(
      categories: categories,
    );
  }
  List<Location>? categories;
}

class Location {
  Location({
    this.subtitle,
    this.typeDish,
    this.videoCode,
    this.images,
    this.name,
    this.origin,
    this.description,
    this.categories,
    this.related,
    this.reference,
  });

  factory Location.fromSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Location newPet = Location.fromJSON(snapshot.data());
    newPet.reference = snapshot.reference;
    return newPet;
  }

  // a factory constructor to create Location instance from json
  factory Location.fromJSON(Map<String, dynamic> json) {
    return factory.makeFromJson(json);
  }
  String? subtitle;
  String? name;
  String? videoCode; //video code intro
  String? origin; //place where this kind of location originates from
  List<Map<String, dynamic>>? description;
  List<String>? categories; // can belong to many categories
  List<String>? related; // tags
  List<String>? images;
  List<String>? typeDish;
  DocumentReference? reference;
  static final LocationFactory factory = LocationFactory();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'subtitle': subtitle,
      'video_code': videoCode,
      'name': name,
      'origin': origin,
      'description': description?.map((Map<String, dynamic> e) => e).toList(),
      'categories': categories?.map((String e) => e).toList(),
      'related': related?.map((String e) => e).toList(),
      'images': images?.map((String e) => e).toList(),
      'type_dish': typeDish?.map((String e) => e).toList(),
    };
  }
}

class LocationFactory {
  Location makeFromJson(Map<String, dynamic> json) {
    return Location(
      subtitle: json['subtitle'] as String?,
      typeDish: parseTypeDish(json['type_dish'] as List<dynamic>?),
      videoCode: json['video_code'] as String?,
      images: parseImages(json['images'] as List<dynamic>?),
      name: json['name'] as String?,
      origin: json['origin'] as String?,
      description: parseDescription(json['description'] as List<dynamic>?),
      related: parseRelateds(json['related'] as List<dynamic>?),
      categories: parseCategories(json['categories'] as List<dynamic>),
    );
  }

  List<Map<String, dynamic>>? parseDescription(List<dynamic>? content) {
    if (content == null) return null;
    List<Map<String, dynamic>> categories = content
        .map(
          (dynamic categoryJson) =>
              Map<String, dynamic>.from(categoryJson as Map<String, dynamic>),
        )
        .toList();
    return categories;
  }

  List<String>? parseCategories(List<dynamic>? categoriesFromJson) {
    if (categoriesFromJson == null) return null;
    List<String> categories = categoriesFromJson
        .map((dynamic categoryJson) => categoryJson.toString())
        .toList();
    return categories;
  }

  List<String>? parseRelateds(List<dynamic>? related) {
    if (related == null) return null;
    List<String> categories =
        related.map((dynamic categoryJson) => categoryJson.toString()).toList();
    return categories;
  }

  List<String>? parseImages(List<dynamic>? images) {
    if (images == null) return null;
    List<String> categories =
        images.map((dynamic categoryJson) => categoryJson.toString()).toList();
    return categories;
  }

  List<String>? parseTypeDish(List<dynamic>? typeDish) {
    if (typeDish == null) return null;
    List<String> categories = typeDish
        .map((dynamic categoryJson) => categoryJson.toString())
        .toList();
    return categories;
  }
}
