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

///Used by [Flip] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class FlipAnimation extends AnimationDefinition {
  FlipAnimation({
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(preferences: preferences);

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return AnimatedBuilder(
      animation: animator.controller,
      child: child,
      builder: (BuildContext context, Widget child) => Transform(
        transform: Perspective.matrix(4.0) *
            Matrix4.translationValues(
                0.0, 0.0, animator.get("translateZ").value) *
            Matrix4.rotationY(-animator.get("rotateY").value) *
            Matrix4.identity().scaled(animator.get("scale").value),
        child: child,
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size screenSize, Size widgetSize}) {
    final cIn = Curves.easeIn;
    final cOut = Curves.easeOut;
    return {
      "scale": TweenList<double>(
        [
          TweenPercentage(percent: 0, value: 1.0, curve: cOut),
          TweenPercentage(percent: 40, value: 1.0, curve: cOut),
          TweenPercentage(percent: 50, value: 1.0, curve: cIn),
          TweenPercentage(percent: 80, value: 0.95, curve: cIn),
          TweenPercentage(percent: 100, value: 1.0, curve: cIn),
        ],
      ),
      "translateZ": TweenList<double>(
        [
          TweenPercentage(percent: 0, value: 0.0, curve: cOut),
          TweenPercentage(percent: 40, value: -150.0, curve: cOut),
          TweenPercentage(percent: 50, value: -150.0, curve: cIn),
          TweenPercentage(percent: 80, value: 0.0, curve: cIn),
        ],
      ),
      "rotateY": TweenList<double>(
        [
          TweenPercentage(percent: 0, value: -360.0 * toRad, curve: cOut),
          TweenPercentage(percent: 40, value: -190.0 * toRad, curve: cOut),
          TweenPercentage(percent: 50, value: -170.0 * toRad, curve: cIn),
          TweenPercentage(percent: 80, value: 0.0, curve: cIn),
        ],
      ),
    };
  }
}

/// Example of using Flip:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return Flip(child: Text('Bounce'));
///   }
///
/// }
/// ```
class Flip extends AnimatorWidget {
  Flip({
    Key key,
    @required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: FlipAnimation(preferences: preferences));
}
