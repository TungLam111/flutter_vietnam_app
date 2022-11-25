import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/pages/home/widget/flip_card.dart';
import 'package:flutter_vietnam_app/pages/home/youtube.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key, required this.location});
  final Location location;
  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: <Widget>[
              PageView.builder(
                onPageChanged: (int value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                controller: _pageController,
                itemCount: widget.location.videoCode == ''
                    ? widget.location.images!.length
                    : widget.location.images!.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == widget.location.images!.length) {
                    return Youtube(idLinkYoutube: widget.location.videoCode!);
                  }
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.location.images![index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[Colors.transparent, Colors.black87],
                      begin: Alignment.center,
                      stops: <double>[0.2, 1],
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              child: const Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.white,
                              ),
                              onTap: () {
                                setState(() {
                                  _currentPage =
                                      (_currentPage > 0) ? _currentPage - 1 : 0;
                                  _pageController.animateToPage(
                                    _currentPage,
                                    duration: const Duration(
                                      milliseconds: 200,
                                    ),
                                    curve: Curves.easeIn,
                                  );
                                });
                              },
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              ),
                              onTap: () {
                                setState(() {
                                  _currentPage = (_currentPage <
                                          widget.location.images!.length + 1)
                                      ? _currentPage + 1
                                      : widget.location.images!.length;
                                  _pageController.animateToPage(
                                    _currentPage,
                                    duration: const Duration(
                                      milliseconds: 200,
                                    ),
                                    curve: Curves.easeIn,
                                  );
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildFlip(),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          color: Colors.black,
                          child: Text(
                            widget.location.origin ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.location.subtitle ?? '',
                          maxLines: 3,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: const <Widget>[
                                Text(
                                  'See more',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.white,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(12),
                              child: const Icon(
                                Icons.arrow_back_ios_rounded,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildFlip() {
    return Column(
      children: <Widget>[
        FlipCard(
          speed: 3000,
          front: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade400,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              widget.location.name.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          back: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.orange.shade200,
            ),
            child: Text(
              widget.location.name.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
