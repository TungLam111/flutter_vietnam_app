import 'package:flutter_vietnam_app/models/item_destination.dart';
import 'package:flutter_vietnam_app/models/comment.dart';

class DestinationList {
  factory DestinationList.fromJson(List<dynamic> parsedJson) {
    List<Destination> categories = parsedJson
        .map(
          (dynamic categoryJson) =>
              Destination.fromJSON(categoryJson as Map<String, dynamic>),
        )
        .toList();

    return DestinationList(
      categories: categories,
    );
  }

  DestinationList({
    this.categories,
  });
  final List<Destination>? categories;
}

class Destination {
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
  factory Destination.fromJSON(Map<String, dynamic> json) {
    return Destination(
      name: json['name'] as String?,
      address: json['address'] as String?,
      description: json['description'] as String?,
      related: factory.parseDestinations(json['related'] as List<dynamic>?),
      nearby: factory.parseDestinations(json['nearby'] as List<dynamic>?),
      relatedNearby:
          factory.parseDestinations(json['relatedNearby'] as List<dynamic>?),
      countComments: json['countComments'] as int?,
      countRatings: json['countRatings'] as int?,
      avgPrice: json['avgPrice'] as int?,
      avgRatings: json['avgRatings'] as double?,
      district: json['district'] as String?,
      province: json['province'] as String?,
      maxPrice: json['maxPrice'] as int?,
      minPrice: json['minPrice'] as int?,
      comments: factory.parseComments(json['comments'] as List<dynamic>?),
      tags: factory.parseTags(json['tags'] as List<dynamic>?),
      types: json['types'] as String?,
      functionalities: factory
          .parseFunctionalities(json['functionalities'] as List<dynamic>?),
      images: factory.parseImages(json['images'] as List<dynamic>?),
      items: factory.parseItems(
        json['items'] as List<dynamic>,
        json['types'] as String,
      ),
    );
  }

  static final DestinationFactory factory = DestinationFactory();
  String? name;
  String? address;
  String? district;
  String? description;
  String? province;
  int? maxPrice;
  int? minPrice;
  int? avgPrice;
  double? avgRatings;
  int? countRatings;
  int? countComments;
  CommentList? comments;
  DestinationList? nearby;
  DestinationList? relatedNearby;
  DestinationList? related;
  ItemList? items;

  List<String>? images;
  List<String>? tags;
  String? types;
  List<String>? functionalities;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'district': district,
      'description': description,
      'province': province,
      'maxPrice': maxPrice,
      'minPrice': minPrice,
      'avgPrice': avgPrice,
      'avgRatings': avgRatings,
      'countComments': countComments,
      'countRatings': countRatings,
      'types': types,
      'comments': comments?.categories
          ?.map((Comment comment) => comment.toJson())
          .toList(),
      'nearby': nearby?.categories
          ?.map((Destination destination) => destination.toJson())
          .toList(),
      'related': related?.categories
          ?.map((Destination destination) => destination.toJson())
          .toList(),
      'relatedNearby': relatedNearby?.categories
          ?.map((Destination destination) => destination.toJson())
          .toList(),
      'items': items?.categories?.map((Item item) => item.toJson()).toList(),
      'images': images?.map((String e) => e).toList(),
      'tags': tags?.map((String tag) => tag).toList(),
      'functionalities':
          functionalities?.map((String function) => function).toList(),
    };
  }
}

class DestinationFactory {
  CommentList? parseComments(List<dynamic>? comments) {
    if (comments?.isNotEmpty == true) {
      return CommentList.fromJson(comments!);
    }
    return null;
  }

  DestinationList? parseDestinations(List<dynamic>? destinations) {
    if (destinations?.isNotEmpty == true) {
      return DestinationList.fromJson(destinations!);
    }
    return null;
  }

  List<String>? parseTags(List<dynamic>? tags) {
    if (tags == null) {
      return null;
    }
    List<String> categories =
        tags.map((dynamic categoryJson) => categoryJson.toString()).toList();
    return categories;
  }

  List<String>? parseFunctionalities(List<dynamic>? functionalities) {
    if (functionalities == null) return null;
    List<String> categories = functionalities
        .map((dynamic categoryJson) => categoryJson.toString())
        .toList();
    return categories;
  }

  List<String>? parseImages(List<dynamic>? images) {
    if (images == null) return null;
    List<String> categories =
        images.map((dynamic categoryJson) => categoryJson.toString()).toList();
    return categories;
  }

  ItemList? parseItems(List<dynamic>? items, String types) {
    if (items == null) {
      return null;
    }
    return ItemList.fromJson(items);
  }
}
