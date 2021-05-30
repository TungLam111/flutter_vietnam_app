import 'package:dcache/dcache.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/models/updateable_model.dart';
import 'package:flutter_vietnam_app/pages/home/home_screen/home_screen.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'item_destination.dart';
import 'package:flutter_vietnam_app/models/comment.dart';

class DestinationList {
  final List<Destination> categories;

  DestinationList({
    this.categories,
  });

  factory DestinationList.fromJson(List<dynamic> parsedJson) {
    List<Destination> categories = parsedJson
        .map((categoryJson) => Destination.fromJSON(categoryJson))
        .toList();

    return new DestinationList(
      categories: categories,
    );
  }
}
class Destination extends UpdatableModel<Destination>{
   String name;
   String address;
   String district; //this
   String description; //thís
   String province; //this
   int maxPrice; //this
   int minPrice; //this
   int avgPrice; //this
   double avgRatings; // plus
   int countRatings; //plus
   int countComments; //plus
   CommentList comments ; //considering
   DestinationList nearby; 
   DestinationList relatedNearby; //this
   DestinationList related; //this
   ItemList items; //
   
   List<String> images;
   List<String> tags; //this
   String types; //currently support 1 types (place for drink, place for wedding, ...)
   List<String> functionalities; //this

  Destination({
    this.name,
    this.address,
    this.district,
    this.description,
    this.province,
    this.maxPrice,
    this.minPrice,
    this.avgPrice,
    this.avgRatings,
    this.countComments,
    this.countRatings,
    this.comments,
    this.images,
    this.nearby,
    this.related,
    this.relatedNearby,
    this.items,
    this.types,
    this.tags,
    this.functionalities,
  });
  
  static final factory = DestinationFactory();

  factory Destination.fromJSON(Map<String, dynamic> json) {
    if (json == null) return null;
    return factory.makeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
     "name" : name,
    "address": address,
    "district": district,
    "description" : description,
    "province": province,
    "maxPrice": maxPrice,
    "minPrice": minPrice,
    "avgPrice": avgPrice,
    "avgRatings": avgRatings,
    "countComments": countComments,
    "countRatings": countRatings,
    "types": types,

    "comments": comments?.comments?.map((Comment comment) => comment.toJson())?.toList(),
    "nearby": nearby?.categories?.map((Destination destination) => destination.toJson())?.toList(),
    "related": related?.categories?.map((Destination destination) => destination.toJson())?.toList(),
    "relatedNearby": relatedNearby?.categories?.map((Destination destination) => destination.toJson())?.toList(),
     "items": items?.categories?.map((Item item) => item.toJson())?.toList(),

    "images": images?.map((String e) => e)?.toList() ,
    "tags": tags?.map((String tag) => tag)?.toList(),
    "functionalities" : functionalities?.map((String function) => function)?.toList(),

    };
  }

  @override
  void updateFromJson(Map json) {
    
    // name o
    if (json.containsKey('name')) {
      name = json['name'];
    }
    //address of that destination
    if (json.containsKey('address')) {
      address = json['address'];
    }
    //district 
    if (json.containsKey('district')) {
      district = json['district'];
    }

    if (json.containsKey('description')) {
      description = json['description'];
    }

    if (json.containsKey('province')) {
      province = json['province'];
    }
    // list images about that destination
    if (json.containsKey('images')) {
      images = factory.parseImages(json['images']);
    }
  
    if (json.containsKey('maxPrice')) {
      maxPrice = json['maxPrice'];
    }

    if (json.containsKey('minPrice')) {
      minPrice = json['minPrice'];
    }
  
    if (json.containsKey('avgPrice')) {
      avgPrice = json['avgPrice'];
    }
    
    if (json.containsKey('avgRatings')){
      avgRatings = json['avgRatings'];
    }
    
    if (json.containsKey('items')) {
      items = factory.parseItems(json['items'], types);
    }

    if (json.containsKey('types')) {
      types = json['types'];
    }

    if (json.containsKey('tags')) {
      tags = factory.parseTags(json['tags']);
    }

    if (json.containsKey('functionalities')) {
      functionalities = factory.parseFunctionalities(json['functionalities']);
    }

    if (json.containsKey('nearby')) {
      nearby = factory.parseDestinations(json['nearby']);
    }

    if (json.containsKey('related')) {
      related = factory.parseDestinations(json['related']);
    }

    if (json.containsKey('relatedNearby')) {
      relatedNearby = factory.parseDestinations(json['relatedNearby']);
    }

    if (json.containsKey('countRatings')) {
      countRatings = json['countRatings'];
    }

      if (json.containsKey('countRatings')) {
      countRatings = json['countRatings'];
    }

      if (json.containsKey('comments')) {
      comments = factory.parseComments(json['comments']);
    }

    
  }
}

class DestinationFactory extends UpdatableModelFactory<Destination> {
  @override
  SimpleCache<int, Destination> cache =
      SimpleCache(storage: UpdatableModelSimpleStorage(size: 20));

  @override
  Destination makeFromJson(Map json) {
    return Destination(
      name: json['name'],
      address: json['address'],
      description: json['description'],
      related: parseDestinations(json['related']),
      nearby: parseDestinations(json['nearby']),
      relatedNearby: parseDestinations(json['relatedNearby']),
      countComments: json['countComments'],
      countRatings: json['countRatings'],
      avgPrice: json['avgPrice'],
      avgRatings: json['avgRatings'],
      district: json['district'],
      province: json['province'],
      maxPrice: json['maxPrice'],
      minPrice: json['minPrice'],
      comments: parseComments(json['comments']),
      tags: parseTags(json['tags']),
      types: json['types'],
      functionalities: parseFunctionalities(json['functionalities']),
      images: parseImages(json['images']),
      items: parseItems(json['items'], json["types"])
    );
  }

  Comment parseComment(Map comment) {
    if (comment == null) return null;
    return Comment.fromJSON(comment);
  }

  CommentList parseComments(List comments) {
    if (comments == null) return null;
    return CommentList.fromJson(comments);
  }

  Destination parseDestination(Map destination) {
    if (destination == null) return null;
    return Destination.fromJSON(destination);
  }

  DestinationList parseDestinations(List destinations) {
    if (destinations == null) return null;
    return DestinationList.fromJson(destinations);
  }
  
  List<String> parseTags(List tags){
    if (tags == null) return null;
    List<String> categories = tags
        .map((categoryJson) => categoryJson.toString())
        .toList();
    return categories;
  }
  
  List<String> parseFunctionalities(List functionalities){
    if (functionalities == null) return null;
    List<String> categories = functionalities
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

  ItemList parseItems(List<String> items, String types){
    if (items == null) return null;
    else if (types == "Food") return ItemList.fromMenu(items);
    return ItemList.fromHotel(items);
  }
}