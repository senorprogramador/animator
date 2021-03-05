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

///Used by [Bounce] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class BounceAnimation extends AnimationDefinition {
  BounceAnimation({
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(preferences: preferences);

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return AnimatedBuilder(
      animation: animator.controller!,
      child: child,
      builder: (BuildContext context, Widget? child) => Transform(
        child: child,
        transform: Matrix4.translationValues(
            0.0, animator.get("translateY")!.value, 0.0),
        alignment: new FractionalOffset(0.5, 1.0),
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size? screenSize, Size? widgetSize}) {
    final floorCurve = Cubic(0.215, 0.61, 0.355, 1);
    final ceilCurve = Cubic(0.755, 0.05, 0.855, 0.06);
    return {
      "translateY": TweenList<double?>(
        [
          TweenPercentage(percent: 0, value: 0.0, curve: floorCurve),
          TweenPercentage(percent: 20, value: 0.0, curve: floorCurve),
          TweenPercentage(percent: 40, value: -30.0, curve: ceilCurve),
          TweenPercentage(percent: 43, value: -30.0, curve: ceilCurve),
          TweenPercentage(percent: 53, value: 0.0, curve: floorCurve),
          TweenPercentage(percent: 70, value: -15.0, curve: ceilCurve),
          TweenPercentage(percent: 80, value: 0.0, curve: floorCurve),
          TweenPercentage(percent: 90, value: -4.0),
          TweenPercentage(percent: 100, value: 0.0, curve: floorCurve),
        ],
      ),
    };
  }
}

/// Example of using Bounce:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return Bounce(child: Text('Bounce'));
///   }
///
/// }
/// ```
class Bounce extends AnimatorWidget {
  Bounce({
    Key? key,
    required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: BounceAnimation(preferences: preferences));
}
