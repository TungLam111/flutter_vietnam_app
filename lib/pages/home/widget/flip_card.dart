import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter_vietnam_app/enum.dart';

class AnimationCard extends StatelessWidget {
  const AnimationCard({
    super.key,
    required this.child,
    required this.animation,
    required this.direction,
  });

  final Widget child;
  final Animation<double> animation;
  final FlipDirection direction;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        Matrix4 transform = Matrix4.identity();
        transform.setEntry(3, 2, 0.001);
        if (direction == FlipDirection.vertical) {
          transform.rotateX(animation.value);
        } else {
          transform.rotateY(animation.value);
        }
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: child,
    );
  }
}

typedef BoolCallback = void Function(bool isFront);

class FlipCard extends StatefulWidget {
  const FlipCard({
    Key? key,
    required this.front,
    required this.back,
    this.speed = 500,
    this.onFlip,
    this.onFlipDone,
    this.direction = FlipDirection.horizontal,
    this.flipOnTouch = true,
  }) : super(key: key);
  final Widget front;
  final Widget back;

  final int speed;
  final FlipDirection direction;
  final VoidCallback? onFlip;
  final BoolCallback? onFlipDone;
  final bool flipOnTouch;

  @override
  State<StatefulWidget> createState() {
    return FlipCardState();
  }
}

class FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _frontRotation;
  late Animation<double> _backRotation;

  bool isFront = true;
  late FlipDirection _direction;
  late Timer _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  @override
  void initState() {
    super.initState();
    _direction = FlipDirection.vertical;
    controller = AnimationController(
      duration: Duration(milliseconds: widget.speed),
      vsync: this,
    );
    _frontRotation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: pi / 2)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
      ],
    ).animate(controller);
    _backRotation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50.0,
        ),
      ],
    ).animate(controller);
    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (widget.onFlipDone != null) widget.onFlipDone?.call(isFront);
      }
    });
    startTimer();
  }

  void toggleCard() {
    if (isFront) {
      controller.forward();
    } else {
      controller.reverse();
    }

    setState(() {
      isFront = !isFront;
    });
    if (widget.onFlip != null) {
      widget.onFlip?.call();
    }
  }

  void startTimer() {
    const Duration oneSec = Duration(milliseconds: 3600);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (seconds < 0) {
            timer.cancel();
          } else {
            toggleCardMany();

            seconds = seconds + 1;
            if (seconds > 59) {
              minutes += 1;
              seconds = 0;
              if (minutes > 59) {
                hours += 1;
                minutes = 0;
              }
            }
          }
        },
      ),
    );
  }

  void toggleCardMany() {
    toggleCard();
    if (_direction == FlipDirection.horizontal) {
      setState(() {
        _direction = FlipDirection.vertical;
      });
    } else {
      setState(() {
        _direction = FlipDirection.horizontal;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stack child = Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        _buildContent(front: true),
        _buildContent(front: false),
      ],
    );

    // if we need to flip the card on taps, wrap the content
    if (widget.flipOnTouch) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: null,
        child: child,
      );
    }
    return child;
  }

  Widget _buildContent({required bool front}) {
    // pointer events that would reach the backside of the card should be
    // ignored
    return IgnorePointer(
      // absorb the front card when the background is active (!isFront),
      // absorb the background when the front is active
      ignoring: front ? !isFront : isFront,
      child: AnimationCard(
        animation: front ? _frontRotation : _backRotation,
        direction: _direction,
        child: front ? widget.front : widget.back,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _timer.cancel();
    super.dispose();
  }
}
