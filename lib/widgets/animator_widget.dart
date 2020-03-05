import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/utils/animator.dart';

class AnimatorPreferences {
  final Duration offset;
  final Duration duration;
  final bool autoPlay;
  final AnimationStatusListener animationStatusListener;

  const AnimatorPreferences({
    this.offset = Duration.zero,
    this.duration = const Duration(seconds: 1),
    this.autoPlay = true,
    this.animationStatusListener,
  });
}

class AnimatorWidget extends StatefulWidget {
  final Widget child;
  final AnimatorPreferences prefs;
  final bool needsWidgetSize;
  final bool needsScreenSize;

  AnimatorWidget({
    Key key,
    @required this.child,
    this.prefs = const AnimatorPreferences(),
    this.needsWidgetSize = false,
    this.needsScreenSize = false,
  }) : super(key: key) {
    assert(child != null, 'Error: child in $this cannot be null');
    assert(prefs != null, 'Error: preferences in $this cannot be null');
    assert(prefs.offset != null, 'Error: offset in $this cannot be null');
    assert(prefs.duration != null, 'Error: duration in $this cannot be null');
  }

  Duration get offset => prefs.offset;
  Duration get duration => prefs.duration;
  AnimationStatusListener get animationStatusListener =>
      prefs.animationStatusListener;

  @override
  AnimatorWidgetState createState() => AnimatorWidgetState();
}

class AnimatorWidgetState<T extends AnimatorWidget> extends State<T>
    with SingleAnimatorStateMixin {
  Size widgetSize;
  Size screenSize;

  AnimationController get controller => animation.controller;

  void loop({bool yoYo = false}) {
    controller.repeat(reverse: yoYo);
  }

  void forward({double from = 0.0}) {
    controller.forward(from: from);
  }

  void reverse({double from = 1.0}) {
    controller.reverse(from: from);
  }

  void stop() {
    controller.stop();
  }

  double get preRenderOpacity => 1.0;

  @override
  void initState() {
    if (widget.needsWidgetSize || widget.needsScreenSize) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          if (widget.needsWidgetSize) {
            RenderBox renderBox = context.findRenderObject();
            widgetSize = renderBox.size;
          }
          if (widget.needsScreenSize) {
            screenSize = MediaQuery.of(context).size;
          }
        });
        refreshAnimation();
      });
    } else {
      refreshAnimation();
    }
    super.initState();
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    if (widget.needsWidgetSize && widgetSize == null) {
      return Opacity(
        opacity: preRenderOpacity,
        child: widget.child,
      );
    }
    if (widget.needsScreenSize && screenSize == null) {
      return Opacity(
        opacity: preRenderOpacity,
        child: widget.child,
      );
    }
    return renderAnimation(context);
  }

  void refreshAnimation() {
    disposeExistingAnimation();
    animation = createAnimation(Animator.sync(this)).generate();
    if (widget.prefs.autoPlay) {
      animation.controller.forward(from: 0.0);
    }
  }

  @override
  void reassemble() {
    if (!kReleaseMode) {
      setState(() {
        refreshAnimation();
      });
    }
    super.reassemble();
  }

  Widget renderAnimation(BuildContext context) {
    throw Exception(
        "AnimatorWidgetState.createAnimation() is marked for override.");
  }

  @override
  Animator createAnimation(Animator animation) {
    throw Exception(
        "AnimatorWidgetState.createAnimation() is marked for override.");
  }
}
