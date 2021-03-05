import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animator/flutter_animator.dart';

import '../animation/animation_definition.dart';
import '../animation/animator.dart';

class AnimatorWidget extends StatefulWidget {
  final Widget child;
  final AnimationDefinition definition;

  AnimatorWidget({
    Key? key,
    required this.child,
    required this.definition,
  }) : super(key: key);

  @override
  AnimatorWidgetState createState() => AnimatorWidgetState();
}

class AnimatorWidgetState<T extends AnimatorWidget> extends State<T>
    implements TickerProvider {
  Size? widgetSize;
  Size? screenSize;

  Animator? animator;
  Ticker? _ticker;

  void loop({bool pingPong = false}) {
    if (animator != null) {
      animator!.loop();
    }
  }

  void forward({double from = 0.0}) {
    if (animator != null) {
      animator!.forward(from: from);
    }
  }

  void reverse({double from = 1.0}) {
    if (animator != null) {
      animator!.reverse(from: from);
    }
  }

  void stop() {
    if (animator != null) {
      animator!.stop();
    }
  }

  void handlePlayState(AnimationPlayStates? playState) {
    switch (playState) {
      case AnimationPlayStates.None:
        break;
      case AnimationPlayStates.Forward:
        forward();
        break;
      case AnimationPlayStates.Reverse:
        reverse();
        break;
      case AnimationPlayStates.Loop:
        loop();
        break;
      case AnimationPlayStates.PingPong:
        loop(pingPong: true);
        break;
      default:
        break;
    }
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    if (widget.definition.needsWidgetSize && widgetSize == null) {
      return Opacity(
        opacity: widget.definition.preRenderOpacity,
        child: widget.child,
      );
    }
    if (widget.definition.needsScreenSize && screenSize == null) {
      return Opacity(
        opacity: widget.definition.preRenderOpacity,
        child: widget.child,
      );
    }
    return animator!.build(context, widget.child);
  }

  void _createAnimator() {
    animator = Animator(vsync: this);
    animator!.setAnimationDefinition(widget.definition);
    if (widget.definition.needsWidgetSize ||
        widget.definition.needsScreenSize) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          if (widget.definition.needsWidgetSize) {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            widgetSize = renderBox.size;
          }
          if (widget.definition.needsScreenSize) {
            screenSize = MediaQuery.of(context).size;
          }
        });
        animator!.resolveDefinition(
          widgetSize: widgetSize,
          screenSize: screenSize,
        );
        handlePlayState(widget.definition.preferences.autoPlay);
      });
    } else {
      animator!.resolveDefinition(
        widgetSize: widgetSize,
        screenSize: screenSize,
      );
      handlePlayState(widget.definition.preferences.autoPlay);
    }
  }

  @override
  void reassemble() {
    if (!kReleaseMode && mounted) {
      disposeExistingAnimation();
      setState(() {
        screenSize = null;
        widgetSize = null;
        _createAnimator();
      });
    }
    super.reassemble();
  }

  @override
  void initState() {
    disposeExistingAnimation();
    screenSize = null;
    widgetSize = null;
    _createAnimator();
    super.initState();
  }

  @override
  void dispose() {
    disposeExistingAnimation();
    super.dispose();
  }

  disposeExistingAnimation() {
    if (animator != null) {
      animator!.dispose();
    }
    if (_ticker != null) {
      _ticker!.dispose();
      _ticker = null;
    }
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    disposeExistingAnimation();

    _ticker =
        Ticker(onTick, debugLabel: kDebugMode ? 'created by $this' : null);
    return _ticker!;
  }

  @override
  void didChangeDependencies() {
    if (_ticker != null) _ticker!.muted = !TickerMode.of(context);
    super.didChangeDependencies();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    String? tickerDescription;
    if (_ticker != null) {
      if (_ticker!.isActive && _ticker!.muted)
        tickerDescription = 'active but muted';
      else if (_ticker!.isActive)
        tickerDescription = 'active';
      else if (_ticker!.muted)
        tickerDescription = 'inactive and muted';
      else
        tickerDescription = 'inactive';
    }
    properties.add(DiagnosticsProperty<Ticker>('ticker', _ticker,
        description: tickerDescription,
        showSeparator: false,
        defaultValue: null));
  }
}
