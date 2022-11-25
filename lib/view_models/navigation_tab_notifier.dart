import 'package:flutter/cupertino.dart';
import 'package:flutter_vietnam_app/enum.dart';

class NavigationTabViewModel extends ChangeNotifier {
  GeneralContentType _state = GeneralContentType.tab1;

  GeneralContentType get state => _state;

  void setState(GeneralContentType newState) {
    _state = newState;
    notifyListeners();
  }
}
