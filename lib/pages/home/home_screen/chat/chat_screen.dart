import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:edge_alert/edge_alert.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'show_pick_time.dart';
import 'another.dart';
import 'chat_app_bar.dart';

//final _firestore = Firestore.instance;
String username = 'User';
String email = 'user@example.com';
String messageText;
User loggedInUser;
String yourImage = "assets/images/avt2.jpeg";

class ChatterScreen extends StatefulWidget {
  @override
  _ChatterScreenState createState() => _ChatterScreenState();
}

class _ChatterScreenState extends State<ChatterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _messageController = TextEditingController();
  final chatMsgTextController = TextEditingController(text: "");
  AutoScrollController controller;
  final scrollDirection = Axis.vertical;
  FocusNode _passwordFocusNode;
  bool _isSubmitted;
  STATE state;
  File _image;
  List<Asset> images;
  final picker = ImagePicker();
  String _error = 'No Error Dectected';
  int currentShowReact = -1;
  List<File> files;

  bool isReply = false;
  //pick image from camera
  Future getImage() async {
    String error;
    PickedFile pickedFile;
    try {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    } on PlatformException catch (e) {
      error = e.message;
    }
    if (!mounted) return;
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        state = STATE.LOADIMAGE;
      } else {
        _error = error;
      }
    });
  }

  Future getFromGallery() async {
    PickedFile pickedFile;
    String error;
    try {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    } on PlatformException catch (e) {
      error = e.message;
    }
    if (!mounted) return;

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        state = STATE.LOADIMAGE;
      });
    } else {
      _error = error;
    }
  }

  Future getMultiFromGallery() async {
    setState(() {
      images = List<Asset>();
    });
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
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
      setState(() {
        images = resultList;
        state = STATE.LOADIMAGE;
      });
    } else
      _error = error;
  }

  Future pickFiles() async {
    FilePickerResult result;
    String error;
    try {
      result = await FilePicker.platform.pickFiles(allowMultiple: true);
    } on PlatformException catch (e) {
      error = e.message;
    }
    if (!mounted) return;

    if (result != null) {
      setState(() {
        files = result.paths.map((path) => File(path)).toList();
        state = STATE.LOADFILE;
        // print(files);
      });
    } else {
      _error = error;
    }
  }

  Future _scrollToIndex(int index) async {
    await controller.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
    controller.highlight(index);
  }

  Widget _wrapScrollTag(int index, Widget child) => AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );

  String extractFileName(String pathFile) {
    var result = pathFile.split('/');
    return result.last.toString();
  }

  String _validateMessage(String text) {
    return "Haha";
  }

  void displayBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.2,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(children: [
                _buildReactBar(context, index),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isReply = true;
                              state = STATE.NONE;
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.keyboard_return))),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.copy))),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.label_important_outline))),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.delete))),
                    ]),
              ]));
        });
  }

  void _displayIconBottom(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
                maxChildSize: 0.85,
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      padding: EdgeInsets.all(10.0),
                      child: Material(child: _gridviewIcons()));
                });
          });
        });
  }

  void _displayNote(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
                maxChildSize: 0.85,
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      padding: EdgeInsets.all(10.0),
                      child: Material(
                        child: ListView(
                            shrinkWrap: true,
                            primary: false,
                            controller: scrollController,
                            children: [
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        child: Row(children: <Widget>[
                                          new Expanded(
                                            child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      maxLines: null,
                                                      controller:
                                                          _messageController,
                                                      validator:
                                                          _validateMessage,
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          15.0,
                                                                      horizontal:
                                                                          15.0),
                                                          labelText: "Message",
                                                          border:
                                                              OutlineInputBorder(),
                                                          errorMaxLines: 3),
                                                      autocorrect: false,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      onFieldSubmitted: (v) =>
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  _passwordFocusNode),
                                                    ),
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  )),
                              DatePickerDemo(),
                              TimePickerDemo(),
                              PickImages()
                            ]),
                      ));
                });
          });
        });
  }

  void _displayOption(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
                maxChildSize: 0.85,
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      padding: EdgeInsets.all(10.0),
                      child: Material(
                        child: ListView(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            primary: false,
                            controller: scrollController,
                            children: [
                              GestureDetector(
                                child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.photo,
                                            color: Colors.deepPurple,
                                            size: 25.0,
                                          ),
                                          SizedBox(width: 30.0),
                                          Text("Take photo from camera",
                                              style: TextStyle(fontSize: 20))
                                        ])),
                                onTap: () {
                                  Navigator.pop(context);
                                  getImage();
                                },
                              ),
                              GestureDetector(
                                  child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15),
                                      padding: EdgeInsets.all(5.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.link,
                                              color: Colors.deepPurple,
                                              size: 25.0,
                                            ),
                                            SizedBox(width: 30.0),
                                            Text("Take photo from library",
                                                style: TextStyle(fontSize: 20))
                                          ])),
                                  onTap: () {
                                    Navigator.pop(context);
                                    getFromGallery();
                                  }),
                              GestureDetector(
                                  child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15),
                                      padding: EdgeInsets.all(5.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Colors.deepPurple,
                                              size: 25.0,
                                            ),
                                            SizedBox(width: 30.0),
                                            Text("Take photos from library",
                                                style: TextStyle(fontSize: 20))
                                          ])),
                                  onTap: () {
                                    Navigator.pop(context);
                                    getMultiFromGallery();
                                  }),
                              GestureDetector(
                                  child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15),
                                      padding: EdgeInsets.all(5.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.add_a_photo_rounded,
                                              color: Colors.deepPurple,
                                              size: 25.0,
                                            ),
                                            SizedBox(width: 30.0),
                                            Text("Take files from library",
                                                style: TextStyle(fontSize: 20))
                                          ])),
                                  onTap: () {
                                    Navigator.pop(context);
                                    pickFiles();
                                  }),
                              GestureDetector(
                                child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.note_add,
                                            color: Colors.deepPurple,
                                            size: 25.0,
                                          ),
                                          SizedBox(width: 30.0),
                                          Text("Take a note",
                                              style: TextStyle(fontSize: 20))
                                        ])),
                                onTap: () {
                                  Navigator.pop(context);
                                  _displayNote(context);
                                },
                              )
                            ]),
                      ));
                });
          });
        });
  }

  Widget imageGridView() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Padding(
          padding: EdgeInsets.all(5),
          child: Stack(
            children: <Widget>[
              AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    images.removeAt(index);
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      color: Colors.white,
                    ),
                    child: Icon(Icons.close, color: Colors.black, size: 18)),
              )
            ],
          ),
        );
      }),
    );
  }
  @override
  void initState() {
    images = [];
    state = STATE.NONE;
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
    _isSubmitted = false;
    super.initState();
    _messageController = new TextEditingController();
    getCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  void getCurrentUser() async {
    try {
      final user = User(
          name: "phandamtunglam", password: "123456", email: "lam@gmail.com");
      if (user != null) {
        loggedInUser = user;
        setState(() {
          username = loggedInUser.name;
          email = loggedInUser.email;
        });
      }
    } catch (e) {
      EdgeAlert.show(context,
          title: 'Something Went Wrong',
          description: e.toString(),
          gravity: EdgeAlert.BOTTOM,
          icon: Icons.error,
          backgroundColor: Colors.deepPurple[900]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatDetailPageAppBar(),

      body: _messageList(),
    );
  }

  Widget _messageList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
            child: GestureDetector(
          onTap: () {
            setState(() {
              state = STATE.NONE;
            });
          },
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
              scrollDirection: scrollDirection,
              controller: controller,
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                // print("${messages[index].replyIndex}");
                var temp = Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: messages[index].user
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      (messages[index].replyIndex != -1)
                          ? GestureDetector(
                              onTap: () => _scrollToIndex(15),
                              child: _buildReplyComponent(
                                  context, messages[index].replyIndex))
                          : Container(),
                      _buildComponentMsg(context, index)
                    ]);
                return _wrapScrollTag(index, temp);
              }),
        )),
           Align(
              alignment: Alignment.bottomLeft,
              child: (images.length != 0) ? imageGridView() : Container(),
            ),
      _buildBottom()
      ],
    );
  }
  
  Widget _buildBottom(){
    return   Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: kMessageContainerDecoration,
            child: Column(children: [
              /*(isReply == true)
                  ? Container(color: Colors.orange, width: 200, height: 100)
                  : Container(),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                   //   elevation: 3.0,
                      child: 
                         Row(
                           children: [
                          Flexible(child: Container(
                       // padding:
                           // const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                        child: TextField(
                          onChanged: (value) {
                            messageText = value;
                          },
                          
                          controller: chatMsgTextController,
                          decoration: kMessageTextFieldDecoration,
                        ),
                        
                      )),
                      Material(
                      borderRadius: BorderRadius.circular(20),
                      // shape: CircleBorder(),
                      color: Colors.grey[100],
                    //  elevation: 3.0,
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 15,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            // print(state);
                            // print(_image == null);
                            messages.insert(
                                0,
                                MessageBubble(
                                    user: true,
                                    msgText: chatMsgTextController.text,
                                    msgSender: username,
                                    image: _image,
                                    replyIndex: (currentShowReact != -1)
                                        ? currentShowReact
                                        : -1,
                                    react: REACTTYPE.NONE,
                                    time: "3:30"));
                          });
                          for (var i = 0; i < messages.length; i++) {
                            if (messages[i].replyIndex != -1)
                              messages[i].replyIndex += 1;
                          }
                          chatMsgTextController.clear();
                          state = STATE.NONE;
                          isReply = false;
                          currentShowReact = -1;
                        },
                      ))
                           ],
                         ) ),
                  ),
                  SizedBox(width: 3.0),
                 /* Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(45),
                      child: IconButton(
                          icon: Icon(Icons.emoji_emotions,
                              color: Colors.deepPurple),
                          onPressed: () {
                            _displayIconBottom(context);
                          })),*/
                  SizedBox(width: 3.0),
                  Material(
                     // elevation: 3.0,
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                      child: GestureDetector(
                          
                          child: Padding( 
                            padding: EdgeInsets.symmetric(vertical:15, horizontal: 5),
                            child: Icon(Icons.add, color: Colors.grey)
                          ),
                          onTap: () {
                            _displayOption(context);
                          })),
                ],
              ),
            ]));
  }
  Widget _buildComponentMsg(BuildContext context, index) {
    return Stack(
      children: [
        Row(
        mainAxisAlignment: messages[index].user
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Expanded(
            child: 
                  GestureDetector(
                      child: _buildChild(context, index),
                      onTap: () {
                        setState(() {
                          state = STATE.NONE;
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          currentShowReact = index;
                          (state != STATE.SHOWREACT)
                              ? state = STATE.SHOWREACT
                              : state = STATE.NONE;
                        });
                        (state == STATE.SHOWREACT)
                            ? displayBottomSheet(context, index)
                            : Container();
                      })
                
          )
        ]),
        _buildImage(index)
         ],);
  }

  Widget _buildImage(int index){
    if (index == messages.length - 1) 
           {
             return Row(
           mainAxisAlignment: (!messages[index].user) ? MainAxisAlignment.start : MainAxisAlignment.end,
           children: [
            (!messages[index].user)
              ? CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage("assets/images/avt1.jpg"),
                )
              : CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage(yourImage),
                ),]);
           } 
   else {
     if (messages[index].user != messages[index+1].user)
         {
            return Row(
           mainAxisAlignment: (!messages[index].user) ? MainAxisAlignment.start : MainAxisAlignment.end,
           children: [
            (!messages[index].user)
              ? CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage("assets/images/avt1.jpg"),
                )
              : CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage(yourImage),
                ),]);
         }
         else {
           return Container();
         }
   }
  }
 
  Widget _buildReactBar(BuildContext context, int index) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    messages[index].react = REACTTYPE.SAD;
                    state = STATE.NONE;
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                    padding: EdgeInsets.all(7.0),
                    child:
                        Image.asset("assets/images/sad.gif", height: 40, width: 40))),
            GestureDetector(
                onTap: () {
                  setState(() {
                    messages[index].react = REACTTYPE.LIKE;
                    state = STATE.NONE;
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                    padding: EdgeInsets.all(7.0),
                    child:
                        Image.asset("assets/images/like.gif", height: 40, width: 40))),
            GestureDetector(
                onTap: () {
                  setState(() {
                    messages[index].react = REACTTYPE.WOW;
                    state = STATE.NONE;
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                    padding: EdgeInsets.all(7.0),
                    child:
                        Image.asset("assets/images/wow.gif", height: 40, width: 40))),
            GestureDetector(
                onTap: () {
                  setState(() {
                    messages[index].react = REACTTYPE.ANGRY;
                    state = STATE.NONE;
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Image.asset("assets/images/angry.gif",
                        height: 40, width: 40))),
            GestureDetector(
                onTap: () {
                  setState(() {
                    messages[index].react = REACTTYPE.HAHA;
                    state = STATE.NONE;
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                    padding: EdgeInsets.all(7.0),
                    child:
                        Image.asset("assets/images/haha.gif", height: 40, width: 40))),
            GestureDetector(
                onTap: () {
                  setState(() {
                    messages[index].react = REACTTYPE.LOVE;
                    state = STATE.NONE;
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                    padding: EdgeInsets.all(7.0),
                    child:
                        Image.asset("assets/images/love.gif", height: 40, width: 40)))
          ],
        ));
  }

  Widget _buildChild(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: messages[index].user
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: <Widget>[
          /*Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "${messages[index].msgSender}",
              style: TextStyle(
                  fontSize: 13, fontFamily: 'Poppins', color: Colors.black87),
            ),
          ),*/
          Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color:
                        messages[index].user ? Colors.grey[200] : Colors.blue[100],
                    //  elevation: 5,
                  ),
                  child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Container(
      constraints: BoxConstraints(minWidth: 50, maxWidth: 200),
      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(children: [
                            Text(
                              messages[index].msgText,
                              style: TextStyle(
                                color: messages[index].user
                                    ? Colors.white
                                    : Colors.white,
                                fontSize: 15,
                              ),
                            )
                          ]),
                        )
    )
  ],  
)
                        ,
                        
                      ])),
             /* (messages[index].react != REACTTYPE.NONE)
                  ? _buildReactComment(context, index)
                  : Container(height: 1, width: 1, color: Colors.transparent)*/
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReplyComponent(BuildContext context, int replyIndex) {
    return _buildChild(context, replyIndex);
  }

  Widget _buildReactComment(BuildContext context, int index) {
    String reactString;
    switch (messages[index].react) {
      case REACTTYPE.ANGRY:
        {
          reactString = "assets/images/angry.gif";
        }
        break;
      case REACTTYPE.SAD:
        {
          reactString = "assets/images/sad.gif";
        }
        break;
      case REACTTYPE.WOW:
        {
          reactString = "assets/images/wow.gif";
        }
        break;
      case REACTTYPE.HAHA:
        {
          reactString = "assets/images/haha.gif";
        }
        break;
      case REACTTYPE.LIKE:
        {
          reactString = "assets/images/like.gif";
        }
        break;
      case REACTTYPE.LOVE:
        {
          reactString = "assets/images/love.gif";
        }
        break;
      default:
        {
          reactString = "none";
        }
        break;
    }
    return Container(
        height: 15,
        width: 15,
        child: Image.asset(
          reactString,
        ));
  }

  Widget _gridviewIcons() {
    return GridView.builder(
        //primary: false,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        itemCount: 20,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.0,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            crossAxisCount: 8),
        itemBuilder: (BuildContext context, int index) {
          String image = "assets/images/icon_ver1/ver1_" + index.toString() + ".png";
          return GestureDetector(
            onTap: () {
              chatMsgTextController.text += image.split("/").last.toString();
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0)),
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(image)))),
          );
        });
  }
}
