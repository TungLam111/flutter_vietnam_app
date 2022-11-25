import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

// ignore: implementation_imports
import 'package:mime/src/default_extension_map.dart';

class UtilsService {
  String _trustedProxyUrl = '';

  static RegExp hashtagsRegExp =
      RegExp(r'\B#\w*[a-zA-Z]+\w*', caseSensitive: false);

  void setTrustedProxyUrl(String proxyUrl) {
    _trustedProxyUrl = proxyUrl;
  }

  Future<bool> fileHasImageMimeType(File file) async {
    String fileMimeType = await getFileMimeType(file);
    MediaType fileMediaType = MediaType.parse(fileMimeType);

    return fileMediaType.type == 'image';
  }

  Future<String?> getFileExtensionForFile(File file) async {
    String fileMimeType = await getFileMimeType(file);

    return getFileExtensionForMimeType(fileMimeType);
  }

  String? getFileExtensionForMimeType(String mimeType) {
    return lookupExtension(mimeType);
  }

  String? geFileNameMimeType(String fileName) {
    return lookupMimeType(fileName);
  }

  Future<String> getFileMimeType(File file) async {
    String? mimeType = lookupMimeType(file.path);

    mimeType ??= await _getFileMimeTypeFromMagicHeaders(file);

    return mimeType ?? 'application/octet-stream';
  }

  List<String?> extractHashtagsInString(String str) {
    return hashtagsRegExp
        .allMatches(str)
        .map((RegExpMatch match) => match.group(0))
        .toList();
  }

  int countHashtagsInString(String str) {
    return extractHashtagsInString(str).length;
  }

  bool colorIsDark(Color color) {
    return color.computeLuminance() < 0.179;
  }

  Future<String?> _getFileMimeTypeFromMagicHeaders(File file) async {
    List<int> fileBytes = file.readAsBytesSync();

    int magicHeaderBytesLeft = 12;
    List<int> magicHeaders = <int>[];

    for (int fileByte in fileBytes) {
      if (magicHeaderBytesLeft == 0) break;
      magicHeaders.add(fileByte);
      magicHeaderBytesLeft--;
    }

    String? mimetype = lookupMimeType(file.path, headerBytes: magicHeaders);

    return mimetype;
  }

  /// Add an override for common extensions since different extensions may map
  /// to the same MIME type.
  final Map<String, String> _preferredExtensionsMap = <String, String>{
    'application/vnd.ms-excel': 'xls',
    'image/jpeg': 'jpg',
    'text/x-c': 'c'
  };

  /// Lookup file extension by a given MIME type.
  /// If no extension is found, `null` is returned.
  String? lookupExtension(String mimeType) {
    if (_preferredExtensionsMap.containsKey(mimeType)) {
      return _preferredExtensionsMap[mimeType];
    }
    String? extension;
    defaultExtensionMap.forEach((String ext, String test) {
      if (mimeType.toLowerCase() == test) {
        extension = ext;
      }
    });
    return extension;
  }

  String getProxiedContentLink(String link) {
    return '$_trustedProxyUrl?$link';
  }

  /* bool hasLinkToPreview(text){
    return getLinkToPreviewFromText(text) != null;
  }*/

  /*String getLinkToPreviewFromText(String text) {
    List matches = [];
    String previewUrl;
    matches.addAll(linkRegex.allMatches(text).map((match) {
      return match.group(0);
    }));

    if (matches.length > 0) {
      Uri url = Uri.parse(matches.first);
      String urlMimeType = geFileNameMimeType(url.path);
      if (urlMimeType != null) {
        String urlFirstType = urlMimeType.split('/').first;
        if (urlFirstType != 'image' && urlFirstType != 'text') return null;
      }
      previewUrl = matches.first;
    }
    return previewUrl;
  }*/

}
