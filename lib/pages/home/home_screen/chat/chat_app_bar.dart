import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatDetailPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    String name = "Phan Dam Tung Lam";
    String username = "tuemantruong";
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
              ),
            
              SizedBox(
                width: 2,
              ),
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/avt1.jpg"),
                maxRadius: 20,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      (username.length > 15) ? "@${username.substring(0, 14)}" : "@$username",
                      style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey[300]),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      (name.length > 15) ? "${name.substring(0, 14)}" : "$name",
                      style: TextStyle( fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              /*IconButton(
                  icon: Icon(Icons.phone, color: Colors.deepPurple),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.video_call, color: Colors.deepPurple),
                  onPressed: () {}),*/
              GestureDetector(
                  child: Icon(Icons.announcement_outlined, color: Colors.orangeAccent),
                  onTap: () {})
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
