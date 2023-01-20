import 'dart:convert';
import 'dart:async';
import 'package:flutter_vietnam_app/utils/utils_service.dart';
import 'dart:io';
import 'package:flutter_vietnam_app/utils/logg.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

part 'httpie_impl.dart';

abstract class Httpie {
  bool retryWhenResponse(http.BaseResponse response);

  bool retryWhenError(dynamic error, StackTrace stackTrace);

  void setAuthorizationToken(String token);

  String? getAuthorizationToken();
  void removeAuthorizationToken();

  void setMagicHeader(String name, String value);
  void setProxy(String proxy);

  Future<HttpieResponse> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  });

  Future<HttpieResponse> put(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  });

  Future<HttpieResponse> patch(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  });
  Future<HttpieResponse> delete(
    String url, {
    Map<String, String>? headers,
    bool? appendAuthorizationToken,
  });

  Future<HttpieResponse> postJSON(
    String url, {
    Map<String, String>? headers = const <String, String>{},
    Map<String, dynamic>? body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  });
  Future<HttpieResponse> putJSON(
    String url, {
    Map<String, String>? headers = const <String, String>{},
    Map<String, dynamic>? body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  });

  Future<HttpieResponse> patchJSON(
    String url, {
    Map<String, String>? headers = const <String, String>{},
    Map<String, dynamic>? body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  });

  Future<HttpieResponse> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    bool? appendAuthorizationToken,
  });

  Future<HttpieStreamedResponse> postMultiform(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Encoding? encoding,
    bool? appendLanguageHeader,
    bool? appendAuthorizationToken,
  });

  Future<HttpieStreamedResponse> patchMultiform(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  });

  Future<HttpieStreamedResponse> putMultiform(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Encoding? encoding,
    bool? appendAuthorizationToken,
  });

  Map<String, String> getHeadersWithConfig({
    Map<String, String>? headers = const <String, String>{},
    bool? appendAuthorizationToken,
  });

  void handleRequestError(Exception error);

  Map<String, String> getJsonHeaders();

  String makeQueryString(Map<String, dynamic> queryParameters);

  String stringifyQueryStringValue(dynamic value);
}

abstract class HttpieBaseResponse<T extends http.BaseResponse> {
  HttpieBaseResponse(this._httpResponse);
  final T _httpResponse;

  bool isInternalServerError() {
    return _httpResponse.statusCode == HttpStatus.internalServerError;
  }

  bool isBadRequest() {
    return _httpResponse.statusCode == HttpStatus.badRequest;
  }

  bool isOk() {
    return _httpResponse.statusCode == HttpStatus.ok;
  }

  bool isUnauthorized() {
    return _httpResponse.statusCode == HttpStatus.unauthorized;
  }

  bool isForbidden() {
    return _httpResponse.statusCode == HttpStatus.forbidden;
  }

  bool isAccepted() {
    return _httpResponse.statusCode == HttpStatus.accepted;
  }

  bool isCreated() {
    return _httpResponse.statusCode == HttpStatus.created;
  }

  bool isNotFound() {
    return _httpResponse.statusCode == HttpStatus.notFound;
  }

  int get statusCode => _httpResponse.statusCode;
}

class HttpieResponse extends HttpieBaseResponse<http.Response> {
  HttpieResponse(http.Response httpResponse) : super(httpResponse);

  String get body {
    return utf8.decode(_httpResponse.bodyBytes);
  }

  Map<String, dynamic> parseJsonBody() {
    return json.decode(body) as Map<String, dynamic>;
  }

  http.Response get httpResponse => _httpResponse;
}

class HttpieStreamedResponse extends HttpieBaseResponse<http.StreamedResponse> {
  HttpieStreamedResponse(http.StreamedResponse httpResponse)
      : super(httpResponse);

  Future<String> readAsString() {
    Completer<String> completer = Completer<String>();
    StringBuffer contents = StringBuffer();
    _httpResponse.stream.transform(utf8.decoder).listen(
      (String data) {
        contents.write(data);
      },
      onDone: () {
        completer.complete(contents.toString());
      },
    );
    return completer.future;
  }
}

class HttpieRequestError<T extends HttpieBaseResponse> implements Exception {
  const HttpieRequestError(this.response);
  static String convertStatusCodeToHumanReadableMessage(int statusCode) {
    String readableMessage;

    if (statusCode == HttpStatus.notFound) {
      readableMessage = 'Not found';
    } else if (statusCode == HttpStatus.forbidden) {
      readableMessage = 'You are not allowed to do this';
    } else if (statusCode == HttpStatus.badRequest) {
      readableMessage = 'Bad request';
    } else if (statusCode == HttpStatus.internalServerError) {
      readableMessage =
          'We\'re experiencing server errors. Please try again later.';
    } else if (statusCode == HttpStatus.serviceUnavailable ||
        statusCode == HttpStatus.serviceUnavailable) {
      readableMessage =
          'We\'re experiencing server errors. Please try again later.';
    } else {
      readableMessage = 'Server error';
    }

    return readableMessage;
  }

  final T response;

  @override
  String toString() {
    String statusCode = response.statusCode.toString();
    String stringifiedError = 'HttpieRequestError:$statusCode';

    if (response is HttpieResponse) {
      HttpieResponse castedResponse = response as HttpieResponse;
      stringifiedError = '$stringifiedError | ${castedResponse.body}';
    }

    return stringifiedError;
  }

  Future<String> body() async {
    String? body;

    if (response is HttpieResponse) {
      HttpieResponse castedResponse = response as HttpieResponse;
      body = castedResponse.body;
    } else if (response is HttpieStreamedResponse) {
      HttpieStreamedResponse castedResponse =
          response as HttpieStreamedResponse;
      body = await castedResponse.readAsString();
    }
    return body ?? '';
  }

  Future<String> toHumanReadableMessage() async {
    String errorBody = await body();

    try {
      dynamic parsedError = json.decode(errorBody);
      if (parsedError is Map) {
        parsedError = parsedError as Map<String, String>;
        if (parsedError.isNotEmpty) {
          if (parsedError.containsKey('detail')) {
            return parsedError['detail']!;
          } else if (parsedError.containsKey('message')) {
            return parsedError['message']!;
          } else {
            dynamic mapFirstValue = parsedError.values.toList().first;
            dynamic value = mapFirstValue is List ? mapFirstValue[0] : null;
            if (value != null && value is String) {
              return value;
            } else {
              return convertStatusCodeToHumanReadableMessage(
                response.statusCode,
              );
            }
          }
        }
        return convertStatusCodeToHumanReadableMessage(response.statusCode);
      } else if (parsedError is List && parsedError.isNotEmpty) {
        return parsedError.first.toString();
      }
      return '';
    } catch (error) {
      return convertStatusCodeToHumanReadableMessage(response.statusCode);
    }
  }
}

class HttpieConnectionRefusedError implements Exception {
  const HttpieConnectionRefusedError(this.socketException);
  final SocketException socketException;

  @override
  String toString() {
    String address = socketException.address.toString();
    String port = socketException.port.toString();
    return '''HttpieConnectionRefusedError: Connection refused on $address and port $port''';
  }

  String toHumanReadableMessage() {
    return 'No internet connection.';
  }
}

class HttpieArgumentsError implements Exception {
  const HttpieArgumentsError(this.msg);
  final String msg;

  @override
  String toString() => 'HttpieArgumentsError: $msg';
}

class HttpieOverrides extends HttpOverrides {
  HttpieOverrides();
  String? _proxy;
  final HttpOverrides? _previous = HttpOverrides.current;

  void setProxy(String proxy) {
    _proxy = proxy;
  }

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    if (_previous != null) return _previous!.createHttpClient(context);
    return super.createHttpClient(context);
  }

  @override
  String findProxyFromEnvironment(Uri url, Map<String, String>? environment) {
    if (_proxy != null) return _proxy!;
    if (_previous != null) {
      return _previous!.findProxyFromEnvironment(url, environment);
    }
    return super.findProxyFromEnvironment(url, environment);
  }
}
