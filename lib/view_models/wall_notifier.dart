import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/repository/location_repo/location_repo.dart';

class WallPageViewModel extends ChangeNotifier {
  WallPageViewModel(this._locationRepository);
  final LocationRepository _locationRepository;

  bool status = false;
  bool isReply = false;
  late bool _isOpen;

  late String _currentFilter;

  List<Post>? _listPost;
  List<Post>? get listPost => _listPost;

  void init() {
    _isOpen = false;
    _currentFilter = 'All';
    getPost();
  }

  void setStatus(bool statusLoading) {
    status = statusLoading;
    notifyListeners();
  }

  void setNewFilter(String filter) async {
    if (filter != _currentFilter) {
      _currentFilter = filter;
      _isOpen = !_isOpen;
      notifyListeners();

      if (_currentFilter == 'All') {
        await getPost();
      } else {
        await getPostFilter();
      }
    }
  }

  void setIsOpen() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

  String get currentFilter => _currentFilter;
  bool get isOpen => _isOpen;

  Future<void> getPost() async {
    List<Post>? data = await _locationRepository.getStreamPost();
    _listPost = data;
    notifyListeners();
  }

  Future<void> getPostFilter() async {
    List<Post>? data =
        await _locationRepository.getStreamPostFilter(_currentFilter);
    _listPost = data;
    notifyListeners();
  }
}
