
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';

import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie.dart';
import 'package:flutter_vietnam_app/services/location/location_service.dart';

class LocationApiService implements LocationService {
  
  static const String apiURL = 'https://shielded-depths-44788.herokuapp.com/';
  static const GET_ALL_LOCATION = 'speciality/ReadAllSpeciality';
  static const GET_LOCATION_BY_NAME = "speciality/ReadSpeciality";
  static const GET_LOCATIONS_BY_LIST = "speciality/ReadListSpecialityByListName";
  static const GET_LOCATIONS_BY_CATEGORY = "speciality/ReadListSpecialityByCategories";

  Httpie _httpService = serviceLocator<Httpie>();


  Future<HttpieResponse> getAllLocations() {
    return this._httpService.postJSON('$apiURL$GET_ALL_LOCATION', appendAuthorizationToken: true);
  }
  
  Future<dynamic> getLocal() async {
    String data =
        await rootBundle.loadString('assets/data/destination_response.json');
    return json.decode(data.toString());
  }
  
  Future<dynamic> getLocation() async {
    String data =
        await rootBundle.loadString('assets/data/food-1.json');
    return json.decode(data.toString());
  }

  Future<HttpieResponse> getLocationByName({@required String locationName}) {
    Map<String, dynamic> body = {"name" : locationName};
    return this._httpService.post('$apiURL$GET_LOCATION_BY_NAME', body: body, appendAuthorizationToken: true);
  }

  Future<HttpieResponse> getLocationsByList(List listLocation){
    Map<String, dynamic> body = {"name": listLocation};
    return this._httpService.postJSON('$apiURL$GET_LOCATIONS_BY_LIST', body: body, appendAuthorizationToken: true);
  }

   Future<HttpieResponse> getLocationsByCategory({String category}){
     Map body = {"categories": category};

    return this._httpService.postJSON('$apiURL$GET_LOCATIONS_BY_CATEGORY', body: body, appendAuthorizationToken: true);
   }
}
