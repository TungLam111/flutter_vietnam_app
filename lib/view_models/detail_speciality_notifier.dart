import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/repository/location_repo/location_repo.dart';

class DishType {
  DishType({
    this.typeDish,
    this.listLocation,
  });

  String? typeDish;
  List<Location>? listLocation;
}

class DetailSpecialityViewModel extends ChangeNotifier {
  DetailSpecialityViewModel(this._locationRepository);
  final LocationRepository _locationRepository;

  List<DishType> listDishType = <DishType>[];

  List<Location>? _listLocation;
  List<Location>? get listLocation => _listLocation;

  void init(List<String>? types) async {
    if (types == null) {
      return;
    }
    listDishType = types.map((String e) => DishType(typeDish: e)).toList();

    for (int index = 0; index < listDishType.length; index++) {
      _getStreamSpecialityByType(listDishType[index].typeDish!)
          .listen((List<Location>? event) {
        listDishType[index].listLocation = event;
        notifyListeners();
      });
    }
  }

  Stream<List<Location>?> _getStreamSpecialityByType(String type) {
    return _locationRepository.getStreamSpecialityByType(type);
  }
}
