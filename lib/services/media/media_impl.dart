import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter_vietnam_app/services/media/media.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';

class MediaServiceImpl implements MediaService{
  final Httpie _httpService = serviceLocator<Httpie>();

  static const String apiURL = 'https://shielded-depths-44788.herokuapp.com/';

  Future<HttpieStreamedResponse> sendImage({@required File file}) async{

    Map<String, dynamic> body = {"image": file}; 

    return _httpService.postMultiform("https://shielded-depths-44788.herokuapp.com/image/upload",
        body: body,
        appendAuthorizationToken: false);
  }

   Future<HttpieResponse> getPredictions({@required String file}) async{
     Map<String, dynamic> body = {"image_name": file};
     return _httpService.postJSON("", body: body, appendAuthorizationToken: false );
   }

   Future<HttpieResponse> getRecommendations() async {
     Map<String, dynamic> body = {};
     return _httpService.postJSON("", body: body, appendAuthorizationToken: false);
   }
}

class StringTemplateService {
  String parse(String string, Map<String, dynamic> values) {
    String finalString = string;

    values.forEach((String key, dynamic value) {
      finalString = finalString.replaceAll('{$key}', value.toString());
    });

    return finalString;
  }
}
