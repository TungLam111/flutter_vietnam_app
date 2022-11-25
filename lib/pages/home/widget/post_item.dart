import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/post.dart';
import 'package:flutter_vietnam_app/pages/home/post_page.dart';
import 'package:intl/intl.dart';

class PostItem extends StatelessWidget {
  const PostItem({required this.post, Key? key}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => PostPage(post: post),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              post.posterModel?.photoUrl ?? '',
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                (post.category?.isNotEmpty == true)
                                    ? Text(
                                        post.category![0],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : const SizedBox(),
                                Text(
                                  "@${post.posterModel?.displayName ?? ''}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(post.postTime!),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  post.images?.isNotEmpty == true
                      ? Image.network(
                          post.images![0],
                          fit: BoxFit.fitWidth,
                          width: 400,
                          height: 200,
                        )
                      : const SizedBox(),
                  Text(
                    post.title ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Wrap(
                    children: post.tags!.map((String e) {
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
