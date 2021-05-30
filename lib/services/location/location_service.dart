
import 'package:flutter/cupertino.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';

abstract class LocationService {
  Future<HttpieResponse> getAllLocations();

  Future<HttpieResponse> getLocationByName({@required String locationName});

  Future<HttpieResponse> getLocationsByList(List listLocation);
  
  Future<dynamic> getLocal();

  Future<dynamic> getLocation();

  Future<HttpieResponse> getLocationsByCategory({String category});
}