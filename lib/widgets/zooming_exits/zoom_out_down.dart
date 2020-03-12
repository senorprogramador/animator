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

///Used by [ZoomOutDown] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class ZoomOutDownAnimation extends AnimationDefinition {
  ZoomOutDownAnimation({
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(preferences: preferences, needsScreenSize: true);

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return FadeTransition(
      opacity: animator.get("opacity"),
      child: AnimatedBuilder(
        animation: animator.controller,
        child: child,
        builder: (BuildContext context, Widget child) => Transform(
          child: child,
          transform: Matrix4.translationValues(
                  0.0, animator.get("translateY").value, 0.0) *
              Matrix4.identity().scaled(animator.get("scale").value),
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size screenSize, Size widgetSize}) {
    final c0 = Cubic(0.55, 0.55, 0.675, 0.19);
    final c1 = Cubic(0.175, 0.885, 0.32, 1.0);
    return {
      "opacity": TweenList<double>(
        [
          TweenPercentage(percent: 40, value: 1.0, curve: c0),
          TweenPercentage(percent: 100, value: 0.0, curve: c1),
        ],
      ),
      "scale": TweenList<double>(
        [
          TweenPercentage(percent: 0, value: 1.0, curve: c0),
          TweenPercentage(percent: 40, value: 0.475, curve: c0),
          TweenPercentage(percent: 100, value: 0.1, curve: c1),
        ],
      ),
      "translateY": TweenList<double>(
        [
          TweenPercentage(percent: 0, value: 0.0, curve: c0),
          TweenPercentage(percent: 40, value: -60.0, curve: c0),
          TweenPercentage(percent: 100, value: screenSize.height, curve: c1),
        ],
      ),
    };
  }
}

/// Example of using ZoomOutDown:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return ZoomOutDown(child: Text('Bounce'));
///   }
///
/// }
/// ```
class ZoomOutDown extends AnimatorWidget {
  ZoomOutDown({
    Key key,
    @required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: ZoomOutDownAnimation(preferences: preferences));
}
