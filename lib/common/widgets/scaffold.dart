import 'package:flutter/cupertino.dart';

class OBCupertinoPageScaffold extends StatelessWidget {
  const OBCupertinoPageScaffold({
    Key? key,
    required this.navigationBar,
    this.backgroundColor = CupertinoColors.white,
    this.resizeToAvoidBottomInset = true,
    this.hasOverlayWidget = false,
    required this.child,
  }) : super(key: key);

  final ObstructingPreferredSizeWidget navigationBar;
  final bool hasOverlayWidget;
  final Widget child;
  final Color backgroundColor;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final List<Widget> stacked = <Widget>[];

    Widget paddedContent = child;
    final MediaQueryData existingMediaQuery = MediaQuery.of(context);

    final double topPadding =
        navigationBar.preferredSize.height + existingMediaQuery.padding.top;

    // Propagate bottom padding and include viewInsets if appropriate

    // [OPENBOOK] Prepare mega-hack!
    double viewInsetsBottom = existingMediaQuery.viewInsets.bottom;

    if (viewInsetsBottom > 50) {
      viewInsetsBottom -= 50;
    }

    final double bottomPadding =
        resizeToAvoidBottomInset ? viewInsetsBottom : 0.0;

//If navigation bar is opaquely obstructing, directly shift the main content
//down. If translucent, let main content draw behind navigation bar but hint the
//obstructed area.
    if (navigationBar.shouldFullyObstruct(context)) {
      paddedContent = Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child: child,
      );
    } else {
      paddedContent = MediaQuery(
        data: existingMediaQuery.copyWith(
          padding: existingMediaQuery.padding.copyWith(
            top: topPadding,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: child,
        ),
      );
    }

    // The main content being at the bottom is added to the stack first.
    stacked.add(paddedContent);

    stacked.add(
      Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        child: navigationBar,
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(color: backgroundColor),
      child: Stack(
        children: stacked,
      ),
    );
  }
}
