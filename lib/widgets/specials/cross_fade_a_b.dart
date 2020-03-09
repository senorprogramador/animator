import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../../flutter_animator.dart';

enum CrossFadePlayStatus { A, B }

class CrossFadeAB extends StatefulWidget {
  final Widget childA;
  final Widget childB;

  CrossFadeAB({
    Key key,
    @required this.childA,
    @required this.childB,
  }) : super(key: key);

  @override
  CrossFadeABState createState() => CrossFadeABState();
}

class CrossFadeABState extends State<CrossFadeAB> implements TickerProvider {
  Animator animatorA;
  Animator animatorB;
  List<Ticker> _tickers = [];
  CrossFadePlayStatus status = CrossFadePlayStatus.A;

  void cross() {
    switch (status) {
      case CrossFadePlayStatus.A:
        animatorA.forward();
        animatorB.reverse();
        break;
      case CrossFadePlayStatus.B:
        animatorA.reverse();
        animatorB.forward();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        animatorA == null
            ? widget.childA
            : animatorA.build(context, widget.childA),
        animatorB == null ? null : animatorB.build(context, widget.childB),
      ].where((widget) => widget != null).toList(),
    );
  }

  void _createAnimators() {
    animatorA = Animator(vsync: this);
    animatorA.setAnimationDefinition(
      FadeOutAnimation(
        preferences: AnimationPreferences(
          animationStatusListener: (AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                this.status = CrossFadePlayStatus.B;
              });
            } else if (status == AnimationStatus.dismissed) {
              setState(() {
                this.status = CrossFadePlayStatus.A;
              });
            }
          },
        ),
      ),
    );
    animatorA.resolveDefinition();

    animatorB = Animator(vsync: this);
    animatorB.setAnimationDefinition(
      FadeOutAnimation(
        preferences: AnimationPreferences(),
      ),
    );
    animatorB.resolveDefinition();
    animatorB.reverse();
    animatorB.stop();
  }

  @override
  void reassemble() {
    if (!kReleaseMode) {
      disposeExistingAnimation();
      setState(() {
        _createAnimators();
      });
    }
    super.reassemble();
  }

  @override
  void initState() {
    disposeExistingAnimation();
    _createAnimators();
    super.initState();
  }

  @override
  void dispose() {
    disposeExistingAnimation();
    super.dispose();
  }

  disposeExistingAnimation() {
    if (animatorA != null) {
      animatorA.dispose();
    }
    if (animatorB != null) {
      animatorB.dispose();
    }
    if (_tickers.length > 0) {
      _tickers.forEach((ticker) => ticker.dispose());
      _tickers.clear();
    }
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    Ticker _ticker =
        Ticker(onTick, debugLabel: kDebugMode ? 'created by $this' : null);
    _tickers.add(_ticker);

    return _ticker;
  }

  @override
  void didChangeDependencies() {
    _tickers.forEach((ticker) => ticker.muted = !TickerMode.of(context));
    super.didChangeDependencies();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    _tickers.forEach((ticker) {
      String tickerDescription;
      if (ticker.isActive && ticker.muted)
        tickerDescription = 'active but muted';
      else if (ticker.isActive)
        tickerDescription = 'active';
      else if (ticker.muted)
        tickerDescription = 'inactive and muted';
      else
        tickerDescription = 'inactive';

      properties.add(DiagnosticsProperty<Ticker>('ticker', ticker,
          description: tickerDescription,
          showSeparator: false,
          defaultValue: null));
    });
  }
}
