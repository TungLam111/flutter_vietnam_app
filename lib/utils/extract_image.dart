import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Extract Image',
      theme: ThemeData.light().copyWith(primaryColor: Colors.deepPurple),
      home: ExtractImage()
    );
  }
}
class ExtractImage extends StatefulWidget {
  @override
  _ExtractImageState createState() => _ExtractImageState();
}

class _ExtractImageState extends State<ExtractImage> {
  File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(onPressed: (){getImage(ImageSource.camera);}, child: Text('Use camera'))),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(onPressed: (){getImage(ImageSource.gallery);}, child: Text('Use gallery'))),
        ],
      ),
        );
  }
  Future getImage(ImageSource imgSource) async {
    final pickedFile = await picker.getImage(source: imgSource);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _cropImage();
        print(_image);
        
      } else {
        print('No image selected.');
      }
    }
  );}
  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Extract an image',
            toolbarColor: Colors.deepPurple,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),);
      setState(() {
        if (croppedFile != null) 
          _image = croppedFile;
      });
    
  }
}