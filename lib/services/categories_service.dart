
import 'httpie.dart';

class CategoriesApiService {
  HttpieService _httpService;

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
