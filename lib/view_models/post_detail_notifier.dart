import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/repository/location_repo/location_repo.dart';

class PostDetailViewModel extends ChangeNotifier {
  PostDetailViewModel(this._locationRepositoy);

  final LocationRepository _locationRepositoy;

  List<Comment>? _listComment = <Comment>[];
  List<Comment>? get listComment => _listComment;
  late Stream<List<Comment>?> _streamComment;
  late StreamSubscription<List<Comment>?> streamCommentSubscription;

  late Post _currentPost;
  Post get currentPost => _currentPost;

  void init(Post post) {
    _currentPost = post;
    _rating = _initialRating;
    _streamComment =
        _locationRepositoy.getStreamComment(_currentPost.reference!.id);
    streamCommentSubscription = _streamComment.listen((List<Comment>? event) {
      _listComment = event;
      notifyListeners();
    });
  }

  int _currentPage = 0;
  int get currentPage => _currentPage;

  final FocusNode _focusNode = FocusNode();
  FocusNode get focusNode => _focusNode;

  final TextEditingController _ratingController = TextEditingController();
  TextEditingController get ratingController => _ratingController;

  final int _ratingBarMode = 1;
  int get ratingBarMode => _ratingBarMode;

  final double _initialRating = 2.0;
  double get initialRating => _initialRating;

  late double _rating;
  double get rating => _rating;

  final bool _isVertical = false;
  bool get isVertical => _isVertical;

  void setCurrentImageView(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void onBackImageView() {
    _currentPage--;
    if (_currentPage == -1) {
      _currentPage = _currentPost.images!.length - 1;
    }
    notifyListeners();
  }

  void onNextImageView() {
    _currentPage++;
    if (_currentPage == _currentPost.images!.length) {
      _currentPage = 0;
    }
    notifyListeners();
  }

  void setRating(double newRating) {
    _rating = newRating;
    notifyListeners();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  Future<void> addComment(Comment comment) async {
    await _locationRepositoy.addComment(comment);
    resetComment();
  }

  resetComment() {
    _rating = 0;
    _ratingController.clear();
    notifyListeners();
  }
}
