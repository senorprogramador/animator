import 'package:flutter/animation.dart';

///[TweenPercentage] is used by the the [TweenList], it defines a value and
///optional curve at a certain percentage of the animation.
class TweenPercentage<T> {
  final double percent;
  final T value;
  final Curve curve;

  const TweenPercentage({
    required this.percent,
    required this.value,
    this.curve = Curves.ease,
  });
}
