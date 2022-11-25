import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/repository/location_repo/location_repo.dart';

class ListviewLocationByTypeNotifer extends ChangeNotifier {
  ListviewLocationByTypeNotifer(this._locationRepository);

  final LocationRepository _locationRepository;

  void init(String filter) {
    _streamAll = _locationRepository.getStreamSpecialityByType(filter);
    streamAllSubscription = _streamAll.listen((List<Location>? event) {
      _listLocation = event;
      notifyListeners();
    });
  }

  late Stream<List<Location>?> _streamAll;
  late StreamSubscription<List<Location>?> streamAllSubscription;
  List<Location>? _listLocation;
  List<Location>? get listLocation => _listLocation;
}
