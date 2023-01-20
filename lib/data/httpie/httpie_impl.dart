part of 'httpie.dart';

class HttpieImpl implements Httpie {
  HttpieImpl(this.client, this._utilsService);

  String? authorizationToken;
  String? magicHeaderName;
  String? magicHeaderValue;
  final http.Client client;
  final UtilsService _utilsService;

  @override
  bool retryWhenResponse(http.BaseResponse response) {
    return response.statusCode >= 503 && response.statusCode < 600;
  }

  @override
  bool retryWhenError(dynamic error, StackTrace stackTrace) {
    return error is SocketException || error is http.ClientException;
  }

  @override
  void setAuthorizationToken(String token) {
    authorizationToken = token;
  }

  @override
  String? getAuthorizationToken() {
    return authorizationToken;
  }

  @override
  void removeAuthorizationToken() {
    authorizationToken = null;
  }

  @override
  void setMagicHeader(String name, String value) {
    magicHeaderName = name;
    magicHeaderValue = value;
  }

  @override
  void setProxy(String proxy) {
    HttpieOverrides overrides = HttpOverrides.current as HttpieOverrides;
    overrides.setProxy(proxy);
  }

  @override
  Future<HttpieResponse> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  }) async {
    Map<String, String> finalHeaders = getHeadersWithConfig(
      headers: headers,
      appendAuthorizationToken: appendAuthorizationToken,
    );

    http.Response? response;

    try {
      response = await client.post(
        Uri.parse(url),
        headers: finalHeaders,
        body: body,
        encoding: encoding,
      );
    } catch (error) {
      handleRequestError(error);
    }

    return HttpieResponse(response!);
  }

  @override
  Future<HttpieResponse> put(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  }) async {
    Map<String, String> finalHeaders = getHeadersWithConfig(
      headers: headers,
      appendAuthorizationToken: appendAuthorizationToken,
    );

    http.Response? response;

    try {
      response = await client.put(
        Uri.parse(url),
        headers: finalHeaders,
        body: body,
        encoding: encoding,
      );
    } catch (error) {
      handleRequestError(error);
    }
    return HttpieResponse(response!);
  }

  @override
  Future<HttpieResponse> patch(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  }) async {
    Map<String, String> finalHeaders = getHeadersWithConfig(
      headers: headers,
      appendAuthorizationToken: appendAuthorizationToken,
    );

    http.Response? response;

    try {
      response = await client.patch(
        Uri.parse(url),
        headers: finalHeaders,
        body: body,
        encoding: encoding,
      );
    } catch (error) {
      handleRequestError(error);
    }

    return HttpieResponse(response!);
  }

  @override
  Future<HttpieResponse> delete(
    String url, {
    Map<String, String>? headers,
    bool? appendAuthorizationToken,
  }) async {
    Map<String, String> finalHeaders = getHeadersWithConfig(
      headers: headers,
      appendAuthorizationToken: appendAuthorizationToken,
    );

    http.Response? response;

    try {
      response = await client.delete(Uri.parse(url), headers: finalHeaders);
    } catch (error) {
      handleRequestError(error);
    }

    return HttpieResponse(response!);
  }

  @override
  Future<HttpieResponse> postJSON(
    String url, {
    Map<String, String>? headers = const <String, String>{},
    Map<String, dynamic>? body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  }) {
    String jsonBody = json.encode(body);

    Map<String, String> jsonHeaders = getJsonHeaders();

    jsonHeaders.addAll(headers!);
    return post(
      url,
      headers: jsonHeaders,
      body: jsonBody,
      encoding: encoding,
      appendAuthorizationToken: appendAuthorizationToken,
    );
  }

  @override
  Future<HttpieResponse> putJSON(
    String url, {
    Map<String, String>? headers = const <String, String>{},
    Map<String, dynamic>? body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  }) {
    String jsonBody = json.encode(body);

    Map<String, String> jsonHeaders = getJsonHeaders();

    jsonHeaders.addAll(headers!);

    return put(
      url,
      headers: jsonHeaders,
      body: jsonBody,
      encoding: encoding,
      appendAuthorizationToken: appendAuthorizationToken,
    );
  }

  @override
  Future<HttpieResponse> patchJSON(
    String url, {
    Map<String, String>? headers = const <String, String>{},
    Map<String, dynamic>? body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  }) {
    String jsonBody = json.encode(body);

    Map<String, String> jsonHeaders = getJsonHeaders();
    jsonHeaders.addAll(headers!);

    return patch(
      url,
      headers: jsonHeaders,
      body: jsonBody,
      encoding: encoding,
      appendAuthorizationToken: appendAuthorizationToken,
    );
  }

  @override
  Future<HttpieResponse> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    bool? appendAuthorizationToken,
  }) async {
    Map<String, String> finalHeaders = getHeadersWithConfig(
      headers: headers,
      appendAuthorizationToken: appendAuthorizationToken,
    );

    if (queryParameters != null && queryParameters.keys.isNotEmpty) {
      url = url + makeQueryString(queryParameters);
    }

    http.Response? response;

    try {
      response = await client.get(Uri.parse(url), headers: finalHeaders);
    } catch (error) {
      handleRequestError(error);
    }

    return HttpieResponse(response!);
  }

  @override
  Future<HttpieStreamedResponse> postMultiform(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Encoding? encoding,
    bool? appendLanguageHeader,
    bool? appendAuthorizationToken,
  }) {
    return _multipartRequest(
      url,
      method: 'POST',
      headers: headers,
      body: body,
      encoding: encoding,
      appendAuthorizationToken: appendAuthorizationToken,
    );
  }

  @override
  Future<HttpieStreamedResponse> patchMultiform(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  }) {
    return _multipartRequest(
      url,
      method: 'PATCH',
      headers: headers,
      body: body,
      encoding: encoding,
      appendAuthorizationToken: appendAuthorizationToken,
    );
  }

  @override
  Future<HttpieStreamedResponse> putMultiform(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  }) {
    return _multipartRequest(
      url,
      method: 'PUT',
      headers: headers,
      body: body,
      encoding: encoding,
      appendAuthorizationToken: appendAuthorizationToken,
    );
  }

  Future<HttpieStreamedResponse> _multipartRequest(
    String url, {
    Map<String, String>? headers,
    required String method,
    Map<String, dynamic>? body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  }) async {
    logg(body);
    http.MultipartRequest request =
        http.MultipartRequest(method, Uri.parse(url));

    Map<String, String> finalHeaders = getHeadersWithConfig(
      headers: headers,
      appendAuthorizationToken: appendAuthorizationToken,
    );

    request.headers.addAll(finalHeaders);

    List<Future<http.MultipartFile>> fileFields =
        <Future<http.MultipartFile>>[];

    List<String> bodyKeys = body?.keys.toList() ?? <String>[];
    logg(bodyKeys);
    for (final String key in bodyKeys) {
      dynamic value = body![key];
      logg(value);
      if (value is String || value is bool) {
        request.fields[key] = value.toString();
      } else if (value is List) {
        request.fields[key] =
            value.map((dynamic item) => item.toString()).toList().join(',');
      } else if (value is File) {
        String fileMimeType = await _utilsService.getFileMimeType(value);

        String? fileExtension =
            _utilsService.getFileExtensionForMimeType(fileMimeType);

        List<int> bytes = utf8.encode(value.path);
        Digest digest = sha256.convert(bytes);

        String newFileName = '$digest.$fileExtension';

        MediaType fileMediaType = MediaType.parse(fileMimeType);

        Future<http.MultipartFile> fileFuture = http.MultipartFile.fromPath(
          key,
          value.path,
          filename: newFileName,
          contentType: fileMediaType,
        );

        fileFields.add(fileFuture);
      } else {
        throw const HttpieArgumentsError('Unsupported multiform value type');
      }
    }

    List<http.MultipartFile> files = await Future.wait(fileFields);
    for (http.MultipartFile file in files) {
      request.files.add(file);
    }

    http.StreamedResponse? response;

    try {
      response = await client.send(request);
    } catch (error) {
      handleRequestError(error);
    }

    return HttpieStreamedResponse(response!);
  }

  @override
  Map<String, String> getHeadersWithConfig({
    Map<String, String>? headers = const <String, String>{},
    bool? appendAuthorizationToken,
  }) {
    headers = headers;

    Map<String, String> finalHeaders = Map<String, String>.from(headers!);
    appendAuthorizationToken = appendAuthorizationToken ?? false;
    if (appendAuthorizationToken && authorizationToken != null) {
      finalHeaders['Authorization'] = '$authorizationToken';
    }

    if (magicHeaderName != null && magicHeaderValue != null) {
      finalHeaders[magicHeaderName!] = magicHeaderValue!;
    }

    return finalHeaders;
  }

  @override
  void handleRequestError(Object error) {
    if (error is SocketException) {
      int errorCode = error.osError!.errorCode;
      if (errorCode == 61 ||
          errorCode == 60 ||
          errorCode == 111 ||
          // Network is unreachable
          errorCode == 101 ||
          errorCode == 104 ||
          errorCode == 51 ||
          errorCode == 8 ||
          errorCode == 113 ||
          errorCode == 7 ||
          errorCode == 64) {
        // Connection refused.
        throw HttpieConnectionRefusedError(error);
      }
    }

    throw error;
  }

  @override
  Map<String, String> getJsonHeaders() {
    return <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  }

  @override
  String makeQueryString(Map<String, dynamic> queryParameters) {
    String queryString = '?';
    queryParameters.forEach((String key, dynamic value) {
      if (value != null) {
        queryString += '$key=${stringifyQueryStringValue(value)}&';
      }
    });
    return queryString;
  }

  @override
  String stringifyQueryStringValue(dynamic value) {
    if (value is String) return value;
    if (value is bool || value is int || value is double) {
      return value.toString();
    }
    if (value is List) {
      return value
          .map((dynamic valueItem) => stringifyQueryStringValue(valueItem))
          .join(',');
    }
    throw 'Unsupported query string value';
  }
}
