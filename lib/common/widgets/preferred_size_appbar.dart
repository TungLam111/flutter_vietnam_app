import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A navigation bar that uses the current theme colours
class OBThemedNavigationBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final Widget leading;
  final String title;
  final Widget trailing;
  final String previousPageTitle;
  final Widget middle;
  final double height;
  final bool checkTimeline;
  final Function ontabTimeline;
  final Color bgColor;
  final String textButton;
  final Color colorButton;
  final Widget overlayWidget;
  final bool autoLeading;
  final EdgeInsetsDirectional padding;

  OBThemedNavigationBar(
      {this.leading,
      this.previousPageTitle,
      this.title,
      this.trailing,
      this.middle,
      this.height = 80,
      this.checkTimeline,
      this.ontabTimeline,
      this.bgColor,
      this.textButton,
      this.colorButton,
      this.overlayWidget,
      this.autoLeading = false,
      this.padding});

  @override
  Widget build(BuildContext context) {
       Color actionsForegroundColor = Colors.white;
        return Column(
          children: [
            !autoLeading ? Container(
              decoration: BoxDecoration(color: bgColor),
              padding: EdgeInsets.only(left: 20, top: 10, bottom:10),
              child: middle
            ) :  Container(
              child: CupertinoNavigationBar(

                  padding: padding ??
                      EdgeInsetsDirectional.only(
                          bottom: 0, start: 15, end: 15, top: 0),
                  border: null,
                  actionsForegroundColor: actionsForegroundColor != null
                      ? actionsForegroundColor
                      : Colors.black,
                  middle: middle != null
                      ? middle
                      : (title != null
                          ? Text(title,
                              style:  GoogleFonts.montserrat(
                                  color: Color(0xff0E6085),
                                  fontSize: 25 ))
                          : const SizedBox(width: 0)),
                  transitionBetweenRoutes: false,
                  backgroundColor: bgColor != null
                      ? bgColor
                      : Colors.white,
                  trailing: trailing ?? const SizedBox(width: 0),
                  leading: (leading != null)
                      ? leading
                      : autoLeading
                          ? GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: SizedBox(
                                width: 20,
                                child: Icon(
                                  Icons.arrow_back_ios_rounded, color: Colors.blueGrey
                                ),
                              ),
                            )
                          : null,
                  automaticallyImplyLeading: autoLeading,
                ),
            ),
             
            if (overlayWidget != null) overlayWidget,
          ],
        );
  }

  /// True if the navigation bar's background color has no transparency.
  @override
  bool get fullObstruction => true;

  @override
  Size get preferredSize {
    return Size.fromHeight(48);
  }

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
