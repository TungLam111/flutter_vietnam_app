import 'add_people.dart';
import 'another.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'chat_screen.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  List<ChatUsers> chatUsers = [
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "Jane Russel",
        secondaryText:
            "Awesome Setup hi my name is Lam Phan Dam Tung Heloo helloooooo",
        image: "assets/images/avt4.jpeg",
        time: "Now",
        countUnread: 1),
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "Glady's Murphy",
        secondaryText: "That's Great",
        image: "assets/images/avt5.jpeg",
        time: "Yesterday",
        countUnread: 23),
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "Jorge Henry",
        secondaryText: "Hey where are you?",
        image: "assets/images/avt6.jpeg",
        time: "31 Mar",
        countUnread: 12),
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "Philip Fox",
        secondaryText: "Busy! Call me in 20 mins",
        image: "assets/images/pic5.jpeg",
        time: "28 Mar",
        countUnread: 0),
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "Debra Hawkins",
        secondaryText: "Thankyou, It's awesome",
        image: "assets/images/avt7.jpeg",
        time: "23 Mar",
        countUnread: 3),
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "Jacob Pena",
        secondaryText: "will update you in evening",
        image: "assets/images/avt8.jpg",
        time: "17 Mar",
        countUnread: 11),
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "Andrey Jones",
        secondaryText: "Can you please share the file?",
        image: "assets/images/avt9.jpeg",
        time: "24 Feb",
        countUnread: 0),
        
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "John Wick",
        secondaryText: "How are you?",
        image: "assets/images/avt10.jpg",
        time: "18 Feb",
        countUnread: 0),
         ChatUsers(
           email: "lamtungphan8@gmail.com",
        text: "Jane Russel",
        secondaryText:
            "Awesome Setup hi my name is Lam Phan Dam Tung Heloo helloooooo",
        image: "assets/images/avt4.jpeg",
        time: "Now",
        countUnread: 1),
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "Glady's Murphy",
        secondaryText: "That's Great",
        image: "assets/images/avt5.jpeg",
        time: "Yesterday",
        countUnread: 23),
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "Jorge Henry",
        secondaryText: "Hey where are you?",
        image: "assets/images/avt6.jpeg",
        time: "31 Mar",
        countUnread: 12),
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "Philip Fox",
        secondaryText: "Busy! Call me in 20 mins",
        image: "assets/images/pic5.jpeg",
        time: "28 Mar",
        countUnread: 0),
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "Debra Hawkins",
        secondaryText: "Thankyou, It's awesome",
        image: "assets/images/avt7.jpeg",
        time: "23 Mar",
        countUnread: 3),
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "Jacob Pena",
        secondaryText: "will update you in evening",
        image: "assets/images/avt8.jpg",
        time: "17 Mar",
        countUnread: 11),
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "Andrey Jones",
        secondaryText: "Can you please share the file?",
        image: "assets/images/avt9.jpeg",
        time: "24 Feb",
        countUnread: 0),
    ChatUsers(
      email: "lamtungphan8@gmail.com",
        text: "John Wick",
        secondaryText: "How are you?",
        image: "assets/images/avt10.jpg",
        time: "18 Feb",
        countUnread: 0),
  ];

  TextTheme textTheme;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    textTheme = Theme.of(context).textTheme;
         return Scaffold(
      body:
         ListView.builder(
              itemCount: chatUsers.length,
              padding: EdgeInsets.only(top: 16),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatUsersList(
                  email: chatUsers[index].email,
                  text: chatUsers[index].text,
                  secondaryText: chatUsers[index].secondaryText,
                  image: chatUsers[index].image,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                  countUnread: chatUsers[index].countUnread,
                );
              },
            ),
         );
  }
  
    _displayDialog(BuildContext context) async {  
    return showDialog(  
        context: context,  
        builder: (context) {  
          return AlertDialog(  
            insetPadding: EdgeInsets.all(1),
            contentPadding: EdgeInsets.all(0.0),
            actionsPadding: EdgeInsets.only(bottom: 30),
           content: AddPeople(),
            actions:[
             
            ]
          );  
        });  
  }  

  @override
  bool get wantKeepAlive => true;
}

class ChatUsersList extends StatefulWidget {
  String text;
  String secondaryText;
  String image;
  String time;
  bool isMessageRead;
  int countUnread;
  String email;
  ChatUsersList(
      {@required this.text,
      @required this.secondaryText,
      @required this.image,
      @required this.time,
      @required this.isMessageRead,
      this.countUnread, this.email});
  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatterScreen();
        }));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 16, top: 13, bottom: 13),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(widget.image),
                        radius: 30,
                      ),
                  Container(
                    padding: const EdgeInsets.only(top: 5,left: 2* (30.0- 6.0) ),
                        child:  
                          (widget.countUnread > 0)
                          ? CircleAvatar(
                            radius: 6,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 5 ,
                              backgroundColor: Colors.green[400],
                             ))
                          : Container()
                      )],
                  
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [ Text(widget.email,
                              style: TextStyle( color: Colors.grey[300],
                                  fontSize:10, fontStyle: FontStyle.italic)),
                                  Text(
                  widget.time,
                  style: TextStyle(
                      fontSize: 12,
                      color: widget.isMessageRead
                          ? Colors.deepPurple
                          : Colors.grey.shade500),
                ),]),
                          Text(widget.text,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      (widget.countUnread > 0) ? 17 : 15)),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Text(
                            (widget.secondaryText.length < 25)
                                ? widget.secondaryText
                                : widget.secondaryText.substring(0, 25),
                            style: TextStyle(
                                fontSize: (widget.countUnread > 0) ? 15 : 13,
                                color: widget.countUnread == 0
                                    ? Colors.grey.shade500
                                    : Colors.black),
                          ),
                   
                      (widget.countUnread > 0)
                          ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(7)),
                              color: Colors.blue[400]),
                                                          child: Text("+${widget.countUnread}",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)))
                          : Container()
                          ])
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
