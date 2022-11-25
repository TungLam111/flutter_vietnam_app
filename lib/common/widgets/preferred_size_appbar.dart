import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OBThemedNavigationBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const OBThemedNavigationBar({
    Key? key,
    this.leading,
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
    this.padding,
  }) : super(key: key);
  final Widget? leading;
  final String? title;
  final Widget? trailing;
  final String? previousPageTitle;
  final Widget? middle;
  final double? height;
  final bool? checkTimeline;
  final Function? ontabTimeline;
  final Color? bgColor;
  final String? textButton;
  final Color? colorButton;
  final Widget? overlayWidget;
  final bool? autoLeading;
  final EdgeInsetsDirectional? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        autoLeading == false
            ? Container(
                decoration: BoxDecoration(color: bgColor),
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: middle,
              )
            : CupertinoNavigationBar(
                padding: padding,
                border: null,
                middle: middle ??
                    (title != null
                        ? Text(
                            title!,
                            style: GoogleFonts.montserrat(
                              color: const Color(0xff0E6085),
                              fontSize: 20,
                            ),
                          )
                        : const SizedBox(width: 0)),
                transitionBetweenRoutes: false,
                backgroundColor: bgColor ?? Colors.white,
                trailing: trailing ?? const SizedBox(width: 0),
                leading: (leading != null)
                    ? leading
                    : autoLeading!
                        ? GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const SizedBox(
                              width: 20,
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.blueGrey,
                              ),
                            ),
                          )
                        : null,
                automaticallyImplyLeading: autoLeading!,
              ),
        if (overlayWidget != null) overlayWidget ?? const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(48);
  }

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
