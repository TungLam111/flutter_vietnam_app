import 'package:dcache/dcache.dart';
import 'package:flutter_vietnam_app/models/updateable_model.dart';
import 'package:flutter_vietnam_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vietnam_app/pages/home/home_screen/home_screen.dart';

class LocationList {
  final List<Location> categories;

  LocationList({
    this.categories,
  });

  factory LocationList.fromJson(List<dynamic> parsedJson) {
    List<Location> categories = parsedJson
        .map((categoryJson) => Location.fromJSON(categoryJson))
        .toList();

    return new LocationList(
      categories: categories,
    );
  }
}
class Location extends UpdatableModel<Location>{
  String subtitle;
   String name; 
   String videoCode; //video code intro
   String origin; //place where this kind of location originates from 
   List<Map<String, dynamic>>  description;
   List<String> categories; // can belong to many categories
   List<String> related; // tags
   List<String> images; 
   List<String> typeDish;
   DocumentReference reference;

  Location({this.subtitle,this.typeDish, this.videoCode, this.images,this.name, this.origin, this.description, this.categories, this.related, this.reference});
    static final factory = LocationFactory();
  
  // a factory constructor to create Location instance from json
  factory Location.fromJSON(Map<String, dynamic> json) {
    if (json == null) return null;
    return factory.makeFromJson(json);
  }
  
  // a factory constructor to create a Location from a Firestore DocumentSnapshot
  factory Location.fromSnapshot(DocumentSnapshot snapshot) {
    Location newPet = Location.fromJSON(snapshot.data);
    newPet.reference = snapshot.reference;
    return newPet;
  }

  Map<String, dynamic> toJson() {
    return {
      'subtitle': subtitle,
      'video_code': videoCode,
      'name': name,
      'origin': origin,
      'description': description?.map((Map e) => e)?.toList(),
      'categories': categories?.map((String e) => e)?.toList(),
      'related': related?.map((String e) => e)?.toList(),
      'images': images?.map((String e) => e)?.toList(),
      'type_dish' : typeDish?.map((String e) => e)?.toList(),
    };
  }

  @override
  void updateFromJson(Map json) {
    if (json.containsKey('subtitle')){
      subtitle = json['subtitle'];
    }
    
    if (json.containsKey('type_dish')){
      typeDish = factory.parseTypeDish(json['type_dish']);
    }

    if (json.containsKey('video_code')){
      videoCode = json['video_code'];
    }

    if (json.containsKey('name')) {
      name = json['name'];
    }

    if (json.containsKey('origin')) {
      origin = json['origin'];
    }

    if (json.containsKey('description')) {
      description = factory.parseDescription(json['description']);
    }

    if (json.containsKey('categories')) {
      categories = factory.parseCategories(json['categories']);
    }

    if (json.containsKey('related')) {
      related = factory.parseRelateds(json['related']);
    }

    if (json.containsKey('images')) {
      images = factory.parseImages(json['images']);
    }
  }
}

class LocationFactory extends UpdatableModelFactory<Location> {
  @override
  SimpleCache<int, Location> cache =
      SimpleCache(storage: UpdatableModelSimpleStorage(size: 20));

  @override
  Location makeFromJson(Map json) {
    return Location(
      subtitle: json['subtitle'],
      typeDish: parseTypeDish(json['type_dish']),
      videoCode: json['video_code'],
      images: parseImages(json['images']),
      name: json['name'],
      origin: json['origin'],
      description: parseDescription(json['description']),
      related: parseRelateds(json['related']),
      categories: parseCategories(json['categories'])
    );
  }
  
   
 List<Map<String, dynamic>> parseDescription(List content){
    if (content == null) return null;
    List<Map<String, dynamic>> categories = content
        .map((categoryJson) => Map<String, dynamic>.from(categoryJson))
        .toList();
    return categories;
  }
  
  List<String> parseCategories(List categoriesFromJson){
    if (categoriesFromJson == null) return null;
    List<String> categories = categoriesFromJson
        .map((categoryJson) => categoryJson.toString())
        .toList();
    return categories;
  }
  
  List<String> parseRelateds(List related){
    if (related == null) return null;
    List<String> categories = related
        .map((categoryJson) => categoryJson.toString())
        .toList();
    return categories;
  }

  List<String> parseImages(List images){
    if (images == null) return null;
    List<String> categories = images
        .map((categoryJson) => categoryJson.toString())
        .toList();
    return categories;
  }

    List<String> parseTypeDish(List typeDish){
    if (typeDish == null) return null;
    List<String> categories = typeDish
        .map((categoryJson) => categoryJson.toString())
        .toList();
    return categories;
  }
}
