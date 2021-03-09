
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';

import '../locator.dart';
import '../web_httpie/httpie.dart';
import 'location_service.dart';

class LocationApiService implements LocationService {
  
  static const String apiURL = 'https://shielded-depths-44788.herokuapp.com/';
  static const GET_ALL_LOCATION = 'speciality/ReadAllSpeciality';
  static const GET_LOCATION_BY_NAME = "";
  static const GET_LOCATIONS_BY_LIST = "";

  Httpie _httpService = serviceLocator<Httpie>();


  Future<HttpieResponse> getAllLocations() {
    return this._httpService.get('$apiURL$GET_ALL_LOCATION', appendAuthorizationToken: true);
  }
  
  Future<dynamic> getCategories() async {
    String data =
        await rootBundle.loadString('assets/data/food (1).json');
    return json.decode(data.toString());
  }
  
  Future<HttpieResponse> getLocationByName({@required String locationName}) {
    Map<String, dynamic> body = {"name" : locationName};
    return _httpService.post('$apiURL$GET_LOCATION_BY_NAME', body: body, appendAuthorizationToken: true);
  }

  Future<HttpieResponse> getLocationsByList(List<String> listLocation){
    Map<String, dynamic> body = {"names": listLocation};
    return _httpService.post('$apiURL$GET_LOCATIONS_BY_LIST', body: body, appendAuthorizationToken: true);
  }
}
