import 'dart:io';

import 'package:flutter_vietnam_app/data/web_httpie/httpie.dart';

abstract class MediaService {
  Future<HttpieStreamedResponse> sendImage({required File file});

  Future<HttpieResponse> getPredictions({required String file});

  Future<HttpieResponse> getRecommendations();
}
