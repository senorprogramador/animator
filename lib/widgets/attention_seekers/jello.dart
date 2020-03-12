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

///Used by [Jello] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class JelloAnimation extends AnimationDefinition {
  JelloAnimation({
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(preferences: preferences);

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return AnimatedBuilder(
      animation: animator.controller,
      child: child,
      builder: (BuildContext context, Widget child) => Transform(
        child: child,
        transform: Matrix4.skew(
            animator.get("transform").value, animator.get("transform").value),
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size screenSize, Size widgetSize}) {
    return {
      "transform": TweenList<double>(
        [
          TweenPercentage(percent: 11, value: 0.0),
          TweenPercentage(percent: 22, value: -12.5 * toRad),
          TweenPercentage(percent: 33, value: 6.25 * toRad),
          TweenPercentage(percent: 44, value: -3.125 * toRad),
          TweenPercentage(percent: 55, value: -1.5625 * toRad),
          TweenPercentage(percent: 66, value: -0.78125 * toRad),
          TweenPercentage(percent: 77, value: 0.390625 * toRad),
          TweenPercentage(percent: 88, value: -0.1953125 * toRad),
          TweenPercentage(percent: 100, value: 0.0),
        ],
      ),
    };
  }
}

/// Example of using Jello:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return Jello(child: Text('Bounce'));
///   }
///
/// }
/// ```
class Jello extends AnimatorWidget {
  Jello({
    Key key,
    @required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: JelloAnimation(preferences: preferences));
}
