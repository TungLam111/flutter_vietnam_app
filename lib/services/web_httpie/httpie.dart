
import 'dart:convert';
import 'dart:async';
import 'package:flutter_vietnam_app/services/utils_service.dart';
import 'package:http/http.dart';
import 'httpie_implement.dart';

abstract class Httpie {

  bool retryWhenResponse(BaseResponse response) ;

  bool retryWhenError(error, StackTrace stackTrace);

  void setAuthorizationToken(String token);

  String getAuthorizationToken() ;
  void removeAuthorizationToken();

  void setUtilsService(UtilsService utilsService);
  void setMagicHeader(String name, String value);
  void setProxy(String proxy) ;

  Future<HttpieResponse> post(url,
      {Map<String, String> headers,
      body,
      Encoding encoding,
      bool appendAuthorizationToken}) ;

  Future<HttpieResponse> put(url,
      {Map<String, String> headers,
      body,
      Encoding encoding,
      bool appendAuthorizationToken});

  Future<HttpieResponse> patch(url,
      {Map<String, String> headers,
      body,
      Encoding encoding,
      bool appendAuthorizationToken}); 
  Future<HttpieResponse> delete(url,
      {Map<String, String> headers,
      bool appendAuthorizationToken}) ;

  Future<HttpieResponse> postJSON(url,
      {Map<String, String> headers = const {},
      body,
      Encoding encoding,
      bool appendAuthorizationToken});
  Future<HttpieResponse> putJSON(url,
      {Map<String, String> headers = const {},
      body,
      Encoding encoding,
      bool appendAuthorizationToken});

  Future<HttpieResponse> patchJSON(url,
      {Map<String, String> headers = const {},
      body,
      Encoding encoding,
      bool appendAuthorizationToken}) ;

  Future<HttpieResponse> get(url,
      {Map<String, String> headers,
      Map<String, dynamic> queryParameters,
      bool appendAuthorizationToken}) ;

  Future<HttpieStreamedResponse> postMultiform(String url,
      {Map<String, String> headers,
      Map<String, dynamic> body,
      Encoding encoding,
      bool appendLanguageHeader,
      bool appendAuthorizationToken});

  Future<HttpieStreamedResponse> patchMultiform(String url,
      {Map<String, String> headers,
      Map<String, dynamic> body,
      Encoding encoding,
      bool appendAuthorizationToken}) {
    return _multipartRequest(url,
        method: 'PATCH',
        headers: headers,
        body: body,
        encoding: encoding,
        appendAuthorizationToken: appendAuthorizationToken);
  }

  Future<HttpieStreamedResponse> putMultiform(String url,
      {Map<String, String> headers,
      Map<String, dynamic> body,
      Encoding encoding,
      bool appendAuthorizationToken}) ;

  Future<HttpieStreamedResponse> _multipartRequest(String url,
      {Map<String, String> headers,
      String method,
      Map<String, dynamic> body,
      Encoding encoding,
      bool appendAuthorizationToken}) ;

  Map<String, String> getHeadersWithConfig(
      {Map<String, String> headers = const {},
      bool appendAuthorizationToken}) ;

  void handleRequestError(error);

  Map<String, String> getJsonHeaders() ;

  String makeQueryString(Map<String, dynamic> queryParameters);

  String stringifyQueryStringValue(dynamic value) ;
}
