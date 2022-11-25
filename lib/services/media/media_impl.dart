import 'dart:io';

import 'package:flutter_vietnam_app/services/media/media.dart';
import 'package:flutter_vietnam_app/data/web_httpie/httpie.dart';

class MediaServiceImpl implements MediaService {
  MediaServiceImpl(this._httpService);
  final Httpie _httpService;

  static const String apiURL = 'https://shielded-depths-44788.herokuapp.com/';

  @override
  Future<HttpieStreamedResponse> sendImage({required File file}) async {
    Map<String, dynamic> body = <String, dynamic>{'image': file};

    return _httpService.postMultiform(
      'https://shielded-depths-44788.herokuapp.com/image/upload',
      body: body,
      appendAuthorizationToken: false,
    );
  }

  @override
  Future<HttpieResponse> getPredictions({required String file}) async {
    Map<String, dynamic> body = <String, dynamic>{'image_name': file};
    return _httpService.postJSON(
      '',
      body: body,
      appendAuthorizationToken: false,
    );
  }

  @override
  Future<HttpieResponse> getRecommendations() async {
    Map<String, dynamic> body = <String, dynamic>{};
    return _httpService.postJSON(
      '',
      body: body,
      appendAuthorizationToken: false,
    );
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
