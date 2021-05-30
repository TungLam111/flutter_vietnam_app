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
   String name;
   String origin;
   String voice;
   String description;
   List<String> categories;
   List<String> related;
   List<String> images;
   
   DocumentReference reference;

  Location({this.images,this.name, this.origin, this.voice, this.description, this.categories, this.related, this.reference});
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
      'name': name,
      'origin': origin,
      'voice': voice,
      'description': description,
      'categories': categories?.map((String e) => e)?.toList(),
      'related': related?.map((String e) => e)?.toList(),
      'images': images?.map((String e) => e)?.toList()
    };
  }

  @override
  void updateFromJson(Map json) {
    if (json.containsKey('name')) {
      name = json['name'];
    }

    if (json.containsKey('origin')) {
      origin = json['origin'];
    }

    if (json.containsKey('voice')) {
      voice = json['voice'];
    }

    if (json.containsKey('description')) {
      description = json['description'];
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
      images: parseImages(json['images']),
      name: json['name'],
      origin: json['origin'],
      description: json['description'],
      related: parseRelateds(json['related']),
      voice: json['voice'],
      categories: parseCategories(json['categories'])
    );
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
}

class CountryModel {
  String label;
  String countryName;
  int noOfTours;
  double rating;
  String imgUrl;

  CountryModel(
      {this.countryName, this.label, this.noOfTours, this.rating, this.imgUrl});
}

class PopularTourModel {
  String imgUrl;
  String title;
  String desc;
  String price;
  double rating;
}


List<CountryModel> getCountrys() {
  List<CountryModel> country = new List();
  CountryModel countryModel = new CountryModel();

//1
  countryModel.countryName = "Thailand";
  countryModel.label = "New";
  countryModel.noOfTours = 18;
  countryModel.rating = 4.5;
  countryModel.imgUrl =
      "https://images.pexels.com/photos/1659438/pexels-photo-1659438.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";
  country.add(countryModel);
  countryModel = new CountryModel();

  //1
  countryModel.countryName = "Malaysia";
  countryModel.label = "Sale";
  countryModel.noOfTours = 12;
  countryModel.rating = 4.3;
  countryModel.imgUrl =
      "https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";
  country.add(countryModel);
  countryModel = new CountryModel();

  //1
  countryModel.countryName = "Thailand";
  countryModel.label = "New";
  countryModel.noOfTours = 18;
  countryModel.rating = 4.5;
  countryModel.imgUrl =
      "https://images.pexels.com/photos/3568489/pexels-photo-3568489.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";
  country.add(countryModel);
  countryModel = new CountryModel();

  //1
  countryModel.countryName = "Thailand";
  countryModel.label = "New";
  countryModel.noOfTours = 18;
  countryModel.rating = 4.5;
  countryModel.imgUrl =
      "https://images.pexels.com/photos/1659438/pexels-photo-1659438.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";
  country.add(countryModel);
  countryModel = new CountryModel();

  //1
  countryModel.countryName = "Thailand";
  countryModel.label = "New";
  countryModel.noOfTours = 18;
  countryModel.rating = 4.5;
  countryModel.imgUrl =
      "https://images.pexels.com/photos/1659438/pexels-photo-1659438.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";
  country.add(countryModel);
  countryModel = new CountryModel();

  //1
  countryModel.countryName = "Thailand";
  countryModel.label = "New";
  countryModel.noOfTours = 18;
  countryModel.rating = 4.5;
  countryModel.imgUrl =
      "https://images.pexels.com/photos/1659438/pexels-photo-1659438.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";
  country.add(countryModel);
  countryModel = new CountryModel();

  //1
  countryModel.countryName = "Thailand";
  countryModel.label = "New";
  countryModel.noOfTours = 18;
  countryModel.rating = 4.5;
  countryModel.imgUrl =
      "https://images.pexels.com/photos/1659438/pexels-photo-1659438.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";
  country.add(countryModel);
  countryModel = new CountryModel();

  return country;
}

List<PopularTourModel> getPopularTours() {
  List<PopularTourModel> popularTourModels = new List();
  PopularTourModel popularTourModel = new PopularTourModel();

//1
  popularTourModel.imgUrl =
      "https://images.pexels.com/photos/358457/pexels-photo-358457.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  popularTourModel.title = "Thailand";
  popularTourModel.desc = "10 nights for two/all inclusive";
  popularTourModel.price = "\$ 245.50";
  popularTourModel.rating = 4.0;
  popularTourModels.add(popularTourModel);
  popularTourModel = new PopularTourModel();

//1
  popularTourModel.imgUrl =
      "https://images.pexels.com/photos/1658967/pexels-photo-1658967.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  popularTourModel.title = "Cuba";
  popularTourModel.desc = "10 nights for two/all inclusive";
  popularTourModel.price = "\$ 499.99";
  popularTourModel.rating = 4.5;
  popularTourModels.add(popularTourModel);
  popularTourModel = new PopularTourModel();

//1
  popularTourModel.imgUrl =
      "https://images.pexels.com/photos/1477430/pexels-photo-1477430.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  popularTourModel.title = "Dominican";
  popularTourModel.desc = "10 nights for two/all inclusive";
  popularTourModel.price = "\$ 245.50";
  popularTourModel.rating = 4.2;
  popularTourModels.add(popularTourModel);
  popularTourModel = new PopularTourModel();

//1
  popularTourModel.imgUrl =
      "https://images.pexels.com/photos/1743165/pexels-photo-1743165.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  popularTourModel.title = "Thailand";
  popularTourModel.desc = "10 nights for two/all inclusive";
  popularTourModel.price = "\$ 245.50";
  popularTourModel.rating = 4.0;
  popularTourModels.add(popularTourModel);
  popularTourModel = new PopularTourModel();

//1
  popularTourModel.imgUrl =
      "https://images.pexels.com/photos/358457/pexels-photo-358457.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  popularTourModel.title = "Thailand";
  popularTourModel.desc = "10 nights for two/all inclusive";
  popularTourModel.price = "\$ 245.50";
  popularTourModel.rating = 4.0;
  popularTourModels.add(popularTourModel);
  popularTourModel = new PopularTourModel();

//1
  popularTourModel.imgUrl =
      "https://images.pexels.com/photos/358457/pexels-photo-358457.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  popularTourModel.title = "Thailand";
  popularTourModel.desc = "10 nights for two/all inclusive";
  popularTourModel.price = "\$ 245.50";
  popularTourModel.rating = 4.0;
  popularTourModels.add(popularTourModel);
  popularTourModel = new PopularTourModel();

//1
  popularTourModel.imgUrl =
      "https://images.pexels.com/photos/358457/pexels-photo-358457.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  popularTourModel.title = "Thailand";
  popularTourModel.desc = "10 nights for two/all inclusive";
  popularTourModel.price = "\$ 245.50";
  popularTourModel.rating = 4.0;
  popularTourModels.add(popularTourModel);
  popularTourModel = new PopularTourModel();

//1
  popularTourModel.imgUrl =
      "https://images.pexels.com/photos/358457/pexels-photo-358457.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  popularTourModel.title = "Thailand";
  popularTourModel.desc = "10 nights for two/all inclusive";
  popularTourModel.price = "\$ 245.50";
  popularTourModel.rating = 4.0;
  popularTourModels.add(popularTourModel);
  popularTourModel = new PopularTourModel();

  return popularTourModels;
}

