import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatDetailPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    String name = "Phan Dam Tung Lam";
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              CircleAvatar(
                backgroundImage: AssetImage("assets/image/lll.jpg"),
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
                      (name.length > 15) ? "${name.substring(0, 14)}" : "$name",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Online",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(Icons.phone, color: Colors.deepPurple),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.video_call, color: Colors.deepPurple),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.deepPurple),
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

/// A navigation bar that uses the current theme colours
class OBThemedNavigationBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final Widget leading;
  final String title;
  final Widget trailing;
  final String previousPageTitle;
  final Widget middle;
  final Widget logo;

  final double height;
  final AnimationController animation;

  OBThemedNavigationBar(
      {this.leading,
      this.previousPageTitle,
      this.title,
      this.trailing,
      this.middle,
      this.logo,
      this.height ,
      this.animation});

  @override
  Widget build(BuildContext context) {

        return Container(
          padding: EdgeInsets.only(top: 20),
          height: height,
          color: Colors.transparent,
          child: Column(
            children: [
              CupertinoNavigationBar(
                padding: EdgeInsetsDirectional.only(
                    bottom: 0, start: 16, end: 16, top: 0),
                border: null,
                middle: middle ??
                    (title != null
                        ? Text(
                            title,
                          )
                        : logo != null
                            ? logo
                            : const SizedBox()),
                transitionBetweenRoutes: false,
                trailing: trailing,
                leading: leading,
              ),
              if (animation != null)
                Semantics(
                  button: true,
                  child: ScaleTransition(
                    scale: animation,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.orange[200],
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          Text(
                            'Thêm tin nhắn mới',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
        
    );
  }

  /// True if the navigation bar's background color has no transparency.
  @override
  bool get fullObstruction => true;

  @override
  Size get preferredSize {
    return const Size.fromHeight(110);
  }

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
