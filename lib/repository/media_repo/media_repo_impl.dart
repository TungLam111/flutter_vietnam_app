import 'dart:convert';
import 'dart:io';

import 'package:flutter_vietnam_app/data/web_httpie/httpie.dart';
import 'package:flutter_vietnam_app/repository/media_repo/media_repo.dart';
import 'package:flutter_vietnam_app/services/exception.dart';
import 'package:flutter_vietnam_app/services/media/media.dart';

class MediaRepositoryImpl implements MediaRepository {
  MediaRepositoryImpl(this._mediaService);
  final MediaService _mediaService;
  @override
  Future<String> sendImage({required File file}) async {
    HttpieStreamedResponse response = await _mediaService.sendImage(file: file);
    if (response.isOk() || response.isAccepted()) {
      String parsed = await response.readAsString();
      return json.decode(parsed)['url'] as String;
    } else if (response.isUnauthorized()) {
      throw const CredentialsMismatchError(
        'The provided credentials do not match.',
      );
    } else {
      throw HttpieRequestError<HttpieStreamedResponse>(response);
    }
  }
}
