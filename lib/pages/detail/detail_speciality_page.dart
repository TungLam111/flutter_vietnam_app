import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/models/location.dart';
import 'package:flutter_vietnam_app/pages/detail/image_widget.dart';
import 'package:flutter_vietnam_app/pages/detail/info_widget.dart';

class DetailSpecialityPage extends StatefulWidget {
  const DetailSpecialityPage({required this.location, Key? key})
      : super(key: key);
  final Location location;
  @override
  State<DetailSpecialityPage> createState() => _DetailSpecialityPageState();
}

class _DetailSpecialityPageState extends State<DetailSpecialityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          ImageWidget(
            location: widget.location,
          ),
          InfoWidget(location: widget.location)
        ],
      ),
    );
  }
}
