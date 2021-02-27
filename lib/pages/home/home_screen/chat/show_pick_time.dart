import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class DatePickerDemo extends StatefulWidget {
  @override
  _DatePickerDemoState createState() => _DatePickerDemoState();
}

class _DatePickerDemoState extends State<DatePickerDemo> {
  /// Which holds the selected date
  /// Defaults to today's date.
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "${selectedDate.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () => _selectDate(context),
            child: Text(
              'Select date',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}

class TimePickerDemo extends StatefulWidget {
  @override
  _TimePickerDemoState createState() => _TimePickerDemoState();
}

class _TimePickerDemoState extends State<TimePickerDemo> {
  /// Which holds the selected date
  /// Defaults to today's date.
  TimeOfDay selectedDate = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "${selectedDate.hour} : ${selectedDate.minute}",
            style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () => _selectTime(context),
            child: Text(
              'Select time',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child,
          );
        });
    setState(() {
      selectedDate = picked;
    });
  }
}

class PickImages extends StatefulWidget {
  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<PickImages> {
  var images;
  String _error;
  Future getMultiFromGallery() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on PlatformException catch (e) {
      error = e.message;
    }
    if (!mounted) return;
    if (resultList != null) {
      if (images == null) {
        setState(() {
          images = resultList;
        });
      } else {
        setState(() {
          for (var i = 0; i < resultList.length; i++) images.add(resultList[i]);
        });
      }
    } else
      _error = error;
  }

  @override
  void initState() {
    images = null;
    images = new List<Asset>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                getMultiFromGallery();
              },
            ),
            (images == null)
                ? Text("No images selected")
                : GridView.builder(
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    itemCount: images.length + 1,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return (index != images.length)
                          ? GestureDetector(
                              onTap: () {},
                              child: AssetThumb(
                                asset: images[index],
                                width: 300,
                                height: 300,
                              ))
                          : GestureDetector(
                              onTap: () {
                                getMultiFromGallery();
                              },
                              child: Container(
                                  color: Colors.grey,
                                  child: Icon(Icons.add_a_photo)));
                    })
          ],
        ));
  }
}
