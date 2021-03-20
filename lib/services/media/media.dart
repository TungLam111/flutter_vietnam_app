
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';

abstract class MediaService  {
  Future<HttpieStreamedResponse> sendImage({@required String username, @required File file});
} 