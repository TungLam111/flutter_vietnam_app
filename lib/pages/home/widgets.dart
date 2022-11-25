import 'package:flutter/material.dart';
import 'dart:math' as math;

// ignore: must_be_immutable
class RotateIcon extends StatefulWidget {
  RotateIcon({Key? key, this.close, this.color}) : super(key: key);
  bool? close;
  Color? color;
  @override
  State<RotateIcon> createState() => RotateIconState();
}

class RotateIconState extends State<RotateIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late bool _close;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 0.0,
    );
    animationController.reverse();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // should refine this using update widget
    _close = widget.close!;
    !_close ? animationController.reverse() : animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      child: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: widget.color,
        size: 25,
      ),
      builder: (BuildContext context, Widget? widgetObj) {
        return Transform.rotate(
          angle: _close
              ? animationController.value * math.pi
              : animationController.value * -math.pi,
          child: widgetObj,
        );
      },
    );
  }
}
