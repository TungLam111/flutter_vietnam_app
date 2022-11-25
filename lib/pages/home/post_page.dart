import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:flutter_vietnam_app/services/locator.dart';
import 'package:flutter_vietnam_app/utils/storage/storage_service.dart';
import 'package:flutter_vietnam_app/view_models/post_detail_notifier.dart';
import 'package:intl/intl.dart';
import 'package:flutter_vietnam_app/common/widgets/preferred_size_appbar.dart';
import 'package:flutter_vietnam_app/common/widgets/scaffold.dart';
import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with TickerProviderStateMixin {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostDetailViewModel>(
      create: (BuildContext context) =>
          serviceLocator<PostDetailViewModel>()..init(widget.post),
      builder: (BuildContext context, Widget? child) =>
          Consumer<PostDetailViewModel>(
        builder: (_, PostDetailViewModel vm, ___) => Scaffold(
          resizeToAvoidBottomInset: true,
          body: Material(
            child: OBCupertinoPageScaffold(
              navigationBar: const OBThemedNavigationBar(
                title: 'Your reading',
                autoLeading: true,
              ),
              resizeToAvoidBottomInset: true,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 25,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                              top: 5,
                            ),
                            height: 200,
                            child: Stack(
                              children: <Widget>[
                                PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: (int value) {
                                    vm.setCurrentImageView(value);
                                  },
                                  itemCount: vm.currentPost.images!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (
                                    BuildContext context,
                                    int index,
                                  ) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            vm.currentPost.images![index],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(
                                            10,
                                          ),
                                          topRight: Radius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () async {
                                            vm.onBackImageView();
                                            await _pageController.animateToPage(
                                              vm.currentPage,
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              curve: Curves.easeIn,
                                            );
                                          },
                                          child: Container(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 5,
                                            ),
                                            child: const Icon(
                                              Icons.arrow_back_ios_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            vm.onNextImageView();
                                            await _pageController.animateToPage(
                                              vm.currentPage,
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              curve: Curves.easeIn,
                                            );
                                          },
                                          child: Container(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 5,
                                            ),
                                            child: const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              (vm.currentPost.category != null &&
                                      vm.currentPost.category!.isNotEmpty)
                                  ? Text(
                                      vm.currentPost.category![0],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                      ),
                                    )
                                  : const SizedBox(),
                              vm.currentPost.postTime != null
                                  ? Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(vm.currentPost.postTime!),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16,
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Text(
                              vm.currentPost.title ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              vm.currentPost.subtitle ?? '',
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    vm.currentPost.posterModel?.photoUrl ?? '',
                                  ),
                                  radius: 30,
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  '@${vm.currentPost.posterModel?.displayName}'
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: vm.currentPost.content!
                                  .map((Map<String, dynamic> e) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 20,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      (e['type'] == 'text')
                                          ? Text(
                                              e['value'].toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                              ),
                                            )
                                          : Image.network(
                                              e['value'].toString(),
                                            ),
                                      const SizedBox(height: 10),
                                      (e['type'] == 'image' &&
                                              e['title'] != null)
                                          ? Text(
                                              e['title'].toString(),
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          vm.currentPost.tags != null
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Wrap(
                                    children:
                                        vm.currentPost.tags!.map((String e) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.blueGrey,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 10,
                                        ),
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                          bottom: 5,
                                        ),
                                        child: Text(
                                          '#${e.toString()}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              : const SizedBox(),
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            margin: const EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Comments',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Selector<PostDetailViewModel, List<Comment>?>(
                            selector:
                                (BuildContext p0, PostDetailViewModel p1) =>
                                    p1.listComment,
                            builder: (_, List<Comment>? comments, ___) =>
                                comments?.isNotEmpty == true
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 0.0),
                                        child: ListView.separated(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          primary: false,
                                          separatorBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) =>
                                              const Divider(),
                                          itemCount: comments!.length,
                                          itemBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) {
                                            return _commentItem(
                                              comments[index],
                                            );
                                          },
                                        ),
                                      )
                                    : const SizedBox(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                              focusNode: vm.focusNode,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: vm.ratingController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: 'Leave your comment',
                                labelText: 'Typing',
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                prefixIcon: GestureDetector(
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                  ),
                                  onTap: () async {
                                    // loadAssets();
                                  },
                                ),
                                suffixIcon: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    List<String> listImages = <String>[];
                                    Comment newComment = Comment(
                                      sender: serviceLocator<StorageService>()
                                          .getCurrentUser()!
                                          .email,
                                      comment: vm.ratingController.text,
                                      location: vm.currentPost.reference!.id,
                                      rating: vm.rating,
                                      time: DateTime.now(),
                                      images: listImages,
                                      displayName:
                                          serviceLocator<StorageService>()
                                              .getCurrentUser()!
                                              .displayName,
                                      photoUrl: serviceLocator<StorageService>()
                                          .getCurrentUser()!
                                          .photoURL,
                                    );
                                    await vm.addComment(newComment);
                                  },
                                  child: const Text('Send'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              bottom: 10,
                              top: 10,
                            ),
                            child: _ratingBar(
                              vm.ratingBarMode,
                              vm.initialRating,
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _commentItem(Comment comment) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                comment.photoUrl.toString(),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '@${comment.displayName}',
                    style: TextStyle(
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    comment.comment.toString(),
                  ),
                ],
              ),
            )
          ],
        ),
        if (comment.images?.isNotEmpty == true)
          imageGridView(
            comment.images!,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (comment.rating != null)
              _ratingBarComment(
                comment.rating!.toDouble(),
              ),
            Text(
              DateFormat(
                'dd/MM/yyyy',
              ).format(
                comment.time!,
              ),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget imageGridView(List<String> listImages) {
    return GridView.count(
      primary: false,
      padding: EdgeInsets.zero,
      crossAxisCount: 3,
      shrinkWrap: true,
      children: listImages.map((String e) {
        return GestureDetector(
          onTap: () {
            showAlertFitWidth(content: Image.network(e), context: context);
          },
          child: Container(
            height: (MediaQuery.of(context).size.width - 30 - 50) * 0.3,
            width: (MediaQuery.of(context).size.width - 30 - 50) * 0.3,
            padding: const EdgeInsets.all(5),
            child: Image.network(
              e.toString(),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<dynamic> showAlertFitWidth({
    required BuildContext context,
    required Widget content,
    dynamic actions,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 30),
          elevation: 5,
          backgroundColor: Colors.white,
          child: content,
        );
      },
    );
  }

  Widget _ratingBar(
    int mode,
    double initialRating,
  ) {
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: 25.0,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (BuildContext context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      glowColor: Colors.yellow,
      onRatingUpdate: (double rating) {
        Provider.of<PostDetailViewModel>(context, listen: false)
            .setRating(rating);
      },
      updateOnDrag: true,
    );
  }

  Widget _ratingBarComment(
    double rating,
  ) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (BuildContext context, int index) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 25.0,
      unratedColor: Colors.amber.withAlpha(50),
      direction: Axis.horizontal,
    );
  }
}
