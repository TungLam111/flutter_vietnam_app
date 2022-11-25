import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vietnam_app/pages/home/widget/post_item.dart';
import 'package:flutter_vietnam_app/view_models/search_notifier.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.black, title: const Text('Searching')),
      body: Consumer<SearchViewModel>(
        builder:
            (BuildContext context, SearchViewModel viewmodel, Widget? child) =>
                Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: viewmodel.listSuggestion?.isNotEmpty == true
                    ? _buildList(context, viewmodel.listSuggestion!)
                    : const SizedBox(),
              ),
              TextField(
                controller: viewmodel.searchController,
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Post> data) {
    return AnimationLimiter(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        shrinkWrap: true,
        primary: false,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: PostItem(post: data[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
