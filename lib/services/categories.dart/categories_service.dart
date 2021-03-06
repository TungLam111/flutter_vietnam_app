
import 'package:flutter_vietnam_app/services/web_httpie/httpie_implement.dart';

import '../locator.dart';
import '../web_httpie/httpie.dart';

class CategoriesApiService {
  Httpie _httpService = serviceLocator<Httpie>();

  static String apiURL = 'https://murmuring-sierra-28458.herokuapp.com';
  static const getCategoriesPath = 'api/categories/';
  
  CategoriesApiService(this._httpService);

  factory CategoriesApiService.create(){
    return CategoriesApiService(HttpieService()); 
  }
  
  void setHttpService(HttpieService httpService) {
    _httpService = httpService;
  }

  Future<HttpieResponse> getCategories() {
    String url = _makeApiUrl(getCategoriesPath);
    return _httpService.get(url, appendAuthorizationToken: true);
  }

  String _makeApiUrl(String string) {
    return '$apiURL$string';
  }
}
