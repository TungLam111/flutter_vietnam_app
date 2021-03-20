import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter_vietnam_app/services/media/media.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';

class MediaServiceImpl implements MediaService{
  final Httpie _httpService = serviceLocator<Httpie>();
  final StringTemplateService _stringTemplateService = StringTemplateService();

  static const String apiURL = "";
    static const SEND_IMAGE_PATH =
      'api/media/{username}/images/';

  Future<HttpieStreamedResponse> sendImage({@required String username, @required File file}) async{
    List<File> files = [];
    files.add(file);
    print(files);
    Map<String, dynamic> body = {"image": file}; 

    return _httpService.putMultiform("http://10.0.2.2:3000/upload-images",
        body: body,
        appendAuthorizationToken: false);
  }

  /* String _makePath(String username) {
    return _stringTemplateService
        .parse(SEND_IMAGE_PATH, {'username': username});
  }

  String _makeApiUrl(String string) {
    return '$apiURL$string';
  }*/
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
