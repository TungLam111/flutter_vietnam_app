
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vietnam_app/services/fake_try/data_repo.dart';
//import 'package:flutter_vietnam_app/models/location.dart';
import 'vaccination.dart';
import 'package:flutter/widgets.dart';
//Icons made by "https://www.flaticon.com/authors/freepik"
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_vietnam_app/services/location/location_service.dart';
import 'package:flutter_vietnam_app/services/service.dart';
import 'package:flutter_vietnam_app/services/service_impl.dart';
import 'package:flutter_vietnam_app/models/comment.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as Path; 
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Pets {
  Pets._();

  static const _kFontFam = 'Pets';

  static const IconData cat = const IconData(0xe800, fontFamily: _kFontFam);
  static const IconData dog_seating = const IconData(0xe801, fontFamily: _kFontFam);
}

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  final DataRepository repository = DataRepository();
  final Service _userService = Service();
  
  bool uploadingImage;
  var _uploadedFileURL;

  @override
  Widget build(BuildContext context) {
    return _buildHome(context);
  }

  Widget _buildHome(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pets"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStreamComment(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();

            return _buildList(context, snapshot.data.documents);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPet();
        },
        tooltip: 'Add Pet',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  
  //upload for asset
  Future saveImage(List<Asset> asset) async {
    StorageUploadTask uploadTask;
    List<String> linkImage = [];
    for (var value in asset) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
      ByteData byteData = await value.requestOriginal(quality: 70);
      var imageData = byteData.buffer.asUint8List();
      uploadTask = ref.putData(imageData);
      String imageUrl;
      await (await uploadTask.onComplete).ref.getDownloadURL().then((onValue) {
        imageUrl = onValue;
      });
      linkImage.add(imageUrl);
    }
    return linkImage;
  }

  //up load for file
  Future uploadPic(File image) async {
  setState(() {
    uploadingImage = true;
  });
  StorageReference storageReference =
      FirebaseStorage.instance.ref().child(Path.basename(image.path));
  StorageUploadTask uploadTask = storageReference.putFile(image);
  await uploadTask.onComplete.then((taskSnapshot) async {
    _uploadedFileURL = await taskSnapshot.ref.getDownloadURL();
    print("Successfully uploaded profile picture");
  }).catchError((e) {
    print("Failed to upload profile picture");
  });
  setState(() {
    uploadingImage = false;
  });
}

  void _addPet() async {
  
    AlertDialogWidget dialogWidget = AlertDialogWidget();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Add Pet"),
              content: dialogWidget,
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),

            
                FlatButton(
                    onPressed: () async {
                      List<String> listImages = await saveImage(dialogWidget.assets);
                      print("+===================");
                      print(listImages);
                      print("=======================");
                      Comment newPet = Comment(sender: dialogWidget.petName, comment: dialogWidget.character , images: listImages );
                      repository.addComment(newPet);
                      Navigator.of(context).pop();
                    },
                    child: Text("Add")),
              ]);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final pet = Comment.fromSnapshot(snapshot);
    if (pet == null) {
      return Container();
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: InkWell(
          child: Column(children: [
            Row(
            children: <Widget>[
              Expanded(child: Text(pet.sender == null ? "" : pet.sender, style: TextStyle(fontWeight: FontWeight.bold))),
            //  _getPetIcon(pet.type)
            ],
          ),
  
         // Image.network("${pet.images[0]}")
          ],),
          onTap: () {
            // _navigate(BuildContext context)  {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => PetDetails(pet),
            //       ));
            // }

            // _navigate(context);
          },
          highlightColor: Colors.green,
          splashColor: Colors.blue,
        ));
  }

}

class AlertDialogWidget extends StatefulWidget {
  String petName;
  String character = '';
  List<Asset> assets = [];
  @override
  _AlertDialogWidgetState createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
 

  //TODO: load multi image
  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: widget.assets,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#000000",
          actionBarTitle: "Pick Product Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
    setState(() {
      widget.assets = resultList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          TextField(
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter a Pet Name"),
            onChanged: (text) => widget.petName = text,
          ),
          GestureDetector( 
            child: Text("hahaha"),
            onTap: () {
              loadAssets();
            }
          ),
          RadioListTile(
            title: Text("Cat"),
            value: "cat",
            groupValue: widget.character,
            onChanged: (String value) {
              setState(() { widget.character = value; });
            },
          ),
          RadioListTile(
            title: Text("Dog"),
            value: "dog",
            groupValue: widget.character,
            onChanged: (String value) {
              setState(() { widget.character = value; });
            },
          ),
          RadioListTile(
            title: Text("Other"),
            value: "other",
            groupValue: widget.character,
            onChanged: (String value) {
              setState(() { widget.character = value; });
            },
          )
        ],
      ),
    );
  }
}

typedef DialogCallback = void Function();

// class PetDetails extends StatelessWidget {
//   final Pet pet;

//   const PetDetails(this.pet);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(pet.name== null ? "" : pet.name),
//           leading: IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               }),
//         ),
//         body: PetDetailForm(pet),
//       ),
//     );
//   }
// }

// //this would be used for updated comment
// class PetDetailForm extends StatefulWidget {
//   final Comment pet;

//   const PetDetailForm(this.pet);

//   @override
//   _PetDetailFormState createState() => _PetDetailFormState();
// }

// class _PetDetailFormState extends State<PetDetailForm> {
//   final DataRepository repository = DataRepository();
//   final _formKey = GlobalKey<FormBuilderState>();
//   final dateFormat = DateFormat('yyyy-MM-dd');
//   String name;
//   String type;
//   String notes;

//   @override
//   void initState() {
//     type = widget.pet.type;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: FormBuilder(
//         key: _formKey,
//         child: Column(
//           children: <Widget>[
//             SizedBox(height: 20.0),
//             FormBuilderTextField(
//               attribute: "name",
//               initialValue: widget.pet.name,
//               decoration: textInputDecoration.copyWith(
//                   hintText: 'Name', labelText: "Pet Name"),
//               validators: [
//                 FormBuilderValidators.minLength(1),
//                 FormBuilderValidators.required()
//               ],
//               onChanged: (val) {
//                 setState(() => name = val);
//               },
//             ),
//             FormBuilderRadio(
//               decoration: InputDecoration(labelText: 'Animal Type'),
//               attribute: "cat",
//               initialValue: type,
//               leadingInput: true,
//               options: [
//                 FormBuilderFieldOption(
//                     value: "cat",
//                     child: Text(
//                       "Cat",
//                       style: TextStyle(fontSize: 16.0),
//                     )),
//                 FormBuilderFieldOption(
//                     value: "dog",
//                     child: Text(
//                       "Dog",
//                       style: TextStyle(fontSize: 16.0),
//                     )),
//                 FormBuilderFieldOption(
//                     value: "other",
//                     child: Text(
//                       "Other",
//                       style: TextStyle(fontSize: 16.0),
//                     )),
//               ],
//               onChanged: (value) {
//                 setState(() {
//                   type = value;
//                 });
//               },
//             ),
//             SizedBox(height: 20.0),
//             FormBuilderTextField(
//               attribute: "notes",
//               initialValue: widget.pet.notes,
//               decoration: textInputDecoration.copyWith(
//                   hintText: 'Notes', labelText: "Notes"),
//               onChanged: (val) {
//                 setState(() {
//                   notes = val;
//                 });
//               },
//             ),
//             FormBuilderCustomField(
//               attribute: "vaccinations",
//               formField: FormField(
//                 enabled: true,
//                 builder: (FormFieldState<dynamic> field) {
//                   return Column(
//                     children: <Widget>[
//                       SizedBox(height: 6.0),
//                       Text(
//                         "Vaccinations",
//                         style: TextStyle(fontSize: 16.0),
//                       ),
//                       ConstrainedBox(
//                         constraints: BoxConstraints(maxHeight: 200),
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           padding: EdgeInsets.all(16.0),
//                           itemCount: widget.pet.vaccinations == null
//                               ? 0
//                               : widget.pet.vaccinations.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return buildRow(widget.pet.vaccinations[index]);
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             FloatingActionButton(
//               onPressed: () {
//                 // _addVaccination(widget.pet, () {
//                 //   setState(() {});
//                 // });
//               },
//               tooltip: 'Add Vaccination',
//               child: Icon(Icons.add),
//             ),
//             SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 MaterialButton(
//                     color: Colors.blue.shade600,
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Text(
//                       "Cancel",
//                       style: TextStyle(color: Colors.white, fontSize: 12.0),
//                     )),
//                 MaterialButton(
//                     color: Colors.blue.shade600,
//                     onPressed: () async {
//                       if (_formKey.currentState.validate()) {
//                         if (_formKey.currentState.validate()) {
//                           Navigator.of(context).pop();
//                           widget.pet.name = name;
//                           widget.pet.type = type;
//                           widget.pet.notes = notes;

//                           repository.updatePet(widget.pet);

//                         }
//                       }
//                     },
//                     child: Text(
//                       "Update",
//                       style: TextStyle(color: Colors.white, fontSize: 12.0),
//                     )),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildRow(Vaccination vaccination) {
//     return Row(
//       children: <Widget>[
//         Expanded(
//           flex: 1,
//           child: Text(vaccination.vaccination),
//         ),
//         Text(vaccination.date == null ? "" : dateFormat.format(vaccination.date)),
//         Checkbox(
//           value: vaccination.done == null ? false : vaccination.done,
//           onChanged: (newValue) {
//             vaccination.done = newValue;
//           },
//         )
//       ],
//     );
//   }

  // void _addVaccination(Comment pet, DialogCallback callback) {
  //   String vaccination;
  //   DateTime vaccinationDate;
  //   bool done = false;
  //   final _formKey = GlobalKey<FormBuilderState>();
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //             title: const Text("Vaccination"),
  //             content: SingleChildScrollView(
  //               child: FormBuilder(
  //                 key: _formKey,
  //                 child: Column(
  //                   children: <Widget>[
  //                     FormBuilderTextField(
  //                       attribute: "vaccination",
  //                       validators: [
  //                         FormBuilderValidators.minLength(1),
  //                         FormBuilderValidators.required()
  //                       ],
  //                       decoration: textInputDecoration.copyWith(
  //                           hintText: 'Enter a Vaccination Name',
  //                           labelText: "Vaccination"),
  //                       onChanged: (text) {
  //                         setState(() {
  //                           vaccination = text;
  //                         });
  //                       },
  //                     ),
  //                     FormBuilderDateTimePicker(
  //                       attribute: "date",
  //                       inputType: InputType.date,
  //                       decoration: textInputDecoration.copyWith(
  //                           hintText: 'Enter a Vaccination Date',
  //                           labelText: "Date"),
  //                       onChanged: (text) {
  //                         setState(() {
  //                           vaccinationDate = text;
  //                         });
  //                       },
  //                     ),
  //                     FormBuilderCheckbox(
  //                       attribute: "given",
  //                       label: Text("Given"),
  //                       onChanged: (text) {
  //                         setState(() {
  //                           done = text;
  //                         });
  //                       },
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             actions: <Widget>[
  //               FlatButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Text("Cancel")),
  //               FlatButton(
  //                   onPressed: () {
  //                     if (_formKey.currentState.validate()) {
  //                       Navigator.of(context).pop();
  //                       Vaccination newVaccination = Vaccination(vaccination,
  //                           date: vaccinationDate, done: done);
  //                       if (pet.vaccinations == null) {
  //                         pet.vaccinations = List<Vaccination>();
  //                       }
  //                       pet.vaccinations.add(newVaccination);
  //                     }
  //                     callback();
  //                   },
  //                   child: Text("Add")),
  //             ]);
  //       });
  // }
//}