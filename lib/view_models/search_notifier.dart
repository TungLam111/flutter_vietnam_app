import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/repository/location_repo/location_repo.dart';

class SearchViewModel extends ChangeNotifier {
  SearchViewModel(this._locationRepository) {
    _searchController.addListener(() {
      if (_searchController.text.isNotEmpty) {
        _onSearch();
      }
    });
  }
  final TextEditingController _searchController =
      TextEditingController(text: '');

  final LocationRepository _locationRepository;

  List<Post>? _listSuggestion;
  List<Post>? get listSuggestion => _listSuggestion;

  @override
  void dispose() {
    _searchController.removeListener(_onSearch);
    _searchController.dispose();
    super.dispose();
  }

  TextEditingController get searchController => _searchController;

  void _onSearch() {
    getStreamSuggestion();
  }

  Future<void> getStreamSuggestion() async {
    List<Post>? data =
        await _locationRepository.getSuggestion(_searchController.text);
    _listSuggestion = data;
    notifyListeners();
  }
}
