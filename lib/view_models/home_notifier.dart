import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/repository/location_repo/location_repo.dart';

class HomePageViewModel extends ChangeNotifier {
  HomePageViewModel(this._locationRepository) {
    _streamAll = _getStreamSpeciality();
    _streamCuisine = _getStreamSpecialityByCategory('Food');
    _streamHeritage = _getStreamSpecialityByCategory('Heritage');
    _streamCulture = _getStreamSpecialityByCategory('Culture');
    _streamSightseeing = _getStreamSpecialityByCategory('Sightseeing');
    _streamHistory = _getStreamSpecialityByCategory('History');
    _streamEthnicity = _getStreamSpecialityByCategory('Ethnicity');

    streamAllSubscription = _streamAll.listen((List<Location>? event) {
      _listLocation = event;
      notifyListeners();
    });
    streamCuisineSubscription = _streamCuisine.listen((List<Location>? event) {
      _listLocationCuisine = event;
      notifyListeners();
    });
    streamHeritageSubscription =
        _streamHeritage.listen((List<Location>? event) {
      _listLocationHeritage = event;
      notifyListeners();
    });
    streamSightseeingSubscription =
        _streamSightseeing.listen((List<Location>? event) {
      _listLocationSightseeing = event;
      notifyListeners();
    });
    streamCultureSubscription = _streamCulture.listen((List<Location>? event) {
      _listLocationCulture = event;
      notifyListeners();
    });
    streamHistorySubscription = _streamHistory.listen((List<Location>? event) {
      _listLocationHistory = event;
      notifyListeners();
    });
    streamEthnicitySubscription =
        _streamEthnicity.listen((List<Location>? event) {
      _listLocationEthnicity = event;
      notifyListeners();
    });
  }
  final LocationRepository _locationRepository;

  bool status = false;
  bool isReply = false;

  late Stream<List<Location>?> _streamAll;
  late StreamSubscription<List<Location>?> streamAllSubscription;
  List<Location>? _listLocation;
  List<Location>? get listLocation => _listLocation;

  late Stream<List<Location>?> _streamCuisine;
  late StreamSubscription<List<Location>?> streamCuisineSubscription;
  List<Location>? _listLocationCuisine;
  List<Location>? get listLocationCuisine => _listLocationCuisine;

  late Stream<List<Location>?> _streamHeritage;
  late StreamSubscription<List<Location>?> streamHeritageSubscription;
  List<Location>? _listLocationHeritage;
  List<Location>? get listLocationHeritage => _listLocationHeritage;

  late Stream<List<Location>?> _streamSightseeing;
  late StreamSubscription<List<Location>?> streamSightseeingSubscription;
  List<Location>? _listLocationSightseeing;
  List<Location>? get listLocationSightseeing => _listLocationSightseeing;

  late Stream<List<Location>?> _streamCulture;
  late StreamSubscription<List<Location>?> streamCultureSubscription;
  List<Location>? _listLocationCulture;
  List<Location>? get listLocationCulture => _listLocationCulture;

  late Stream<List<Location>?> _streamHistory;
  late StreamSubscription<List<Location>?> streamHistorySubscription;
  List<Location>? _listLocationHistory;
  List<Location>? get listLocationHistory => _listLocationHistory;

  late Stream<List<Location>?> _streamEthnicity;
  late StreamSubscription<List<Location>?> streamEthnicitySubscription;
  List<Location>? _listLocationEthnicity;
  List<Location>? get listLocationEthnicity => _listLocationEthnicity;

  Stream<List<Location>?> _getStreamSpeciality() {
    return _locationRepository.getStreamSpeciality();
  }

  Stream<List<Location>?> _getStreamSpecialityByCategory(String filter) {
    return _locationRepository.getStreamSpecialityByCategory(filter);
  }

  void setStatus(bool statusLoading) {
    status = statusLoading;
    notifyListeners();
  }

  addLocation(Location location) async {
    await _locationRepository.addLocation(location);
  }

  @override
  void dispose() {
    super.dispose();
    streamEthnicitySubscription.cancel();
  }
}
