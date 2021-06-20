

import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vietnam_app/services/fake_try/data_repo.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'post_item.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController;
  final DataRepository repository = DataRepository();

  String _searchKey;

  @override 
  void initState(){
    super.initState();
    _searchKey = "";
    searchController = new TextEditingController();
  }
  
  @override 
  void dispose(){
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Searching")
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Stack(children: [
          Padding(
            padding: EdgeInsets.only(top: 60),
            child:( _searchKey != "" && _searchKey != null )? StreamBuilder<QuerySnapshot>(
              stream:  repository.getSuggestion(_searchKey) ,
              builder: (context, snapshot) {
                          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
            List<DocumentSnapshot> data = snapshot.data.documents;
                return _buildList(context, data);
              }
            ) : SizedBox()
          ),
          TextField(
            controller: searchController,
                style: TextStyle(fontSize: 12),
                onChanged: (value) {
                  setState(() {
                    
                    _searchKey = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search...",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        _searchKey = searchController.text;
                      });
                    },
                                      child: Icon(
                      Icons.search,
                      color: Colors.black,
                      
                    ),
                  ),
                ),
              ),
        ],),
      ) ,
    );
  }

  
  Widget _buildList(BuildContext context, List<DocumentSnapshot> data) {
    return AnimationLimiter(
        child: ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(),
      shrinkWrap: true,
      primary: false,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                    child: PostItem(post: Post.fromSnapshot(data[index])))));
      },
    ));
  }
}