/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2020 Sjoerd van den Berg
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'package:flutter/widgets.dart';

import '../../flutter_animator.dart';

enum FlipInXOrigin {
  back,
  front,
}

///Used by [FlipInX] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class FlipInXAnimation extends AnimationDefinition {
  final FlipInXOrigin from;
  final Alignment alignment;

  FlipInXAnimation({
    this.from = FlipInXOrigin.front,
    this.alignment: Alignment.center,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(preferences: preferences);

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return FadeTransition(
      opacity: animator.get("opacity") as Animation<double>,
      child: AnimatedBuilder(
        animation: animator.controller!,
        child: child,
        builder: (BuildContext context, Widget? child) => Transform(
          transform: Perspective.matrix(4.0) *
              Matrix4.rotationX(-animator.get("rotateX")!.value),
          child: child,
          alignment: alignment,
        ),
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size? screenSize, Size? widgetSize}) {
    double multiplier = from == FlipInXOrigin.front ? -1.0 : 1.0;
    if (alignment == Alignment.topCenter ||
        alignment == Alignment.topLeft ||
        alignment == Alignment.topRight) {
      multiplier *= -1;
    }
    return {
      "opacity": TweenList<double?>(
        [
          TweenPercentage(percent: 0, value: 0.0, curve: Curves.easeIn),
          TweenPercentage(percent: 60, value: 1.0),
        ],
      ),
      "rotateX": TweenList<double?>(
        [
          TweenPercentage(
              percent: 0,
              value: multiplier * 90.0 * toRad,
              curve: Curves.easeIn),
          TweenPercentage(
              percent: 40,
              value: multiplier * -20.0 * toRad,
              curve: Curves.easeIn),
          TweenPercentage(percent: 60, value: multiplier * 10.0 * toRad),
          TweenPercentage(percent: 80, value: multiplier * -5.0 * toRad),
          TweenPercentage(percent: 100, value: 0.0),
        ],
      ),
    };
  }
}

/// Example of using FlipInX:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return FlipInX(child: Text('Bounce'));
///   }
///
/// }
/// ```
class FlipInX extends AnimatorWidget {
  FlipInX({
    Key? key,
    required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: FlipInXAnimation(preferences: preferences));
}
