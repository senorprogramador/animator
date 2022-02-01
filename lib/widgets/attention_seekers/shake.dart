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

///Used by [Shake] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class ShakeAnimation extends AnimationDefinition {
  ShakeAnimation({
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
            animator.get("translateX")!.value, 0.0, 0.0),
        alignment: FractionalOffset(0.5, 0.5),
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size? screenSize, Size? widgetSize}) {
    final a = 0.0;
    final b = -10.0 * preferences.magnitude;
    final c = 10.0 * preferences.magnitude;
    return {
      "translateX": TweenList<double>(
        [
          TweenPercentage(percent: 0, value: a),
          TweenPercentage(percent: 10, value: b),
          TweenPercentage(percent: 20, value: c),
          TweenPercentage(percent: 30, value: b),
          TweenPercentage(percent: 40, value: c),
          TweenPercentage(percent: 50, value: b),
          TweenPercentage(percent: 60, value: c),
          TweenPercentage(percent: 70, value: b),
          TweenPercentage(percent: 80, value: c),
          TweenPercentage(percent: 90, value: b),
          TweenPercentage(percent: 100, value: a),
        ],
      ),
    };
  }
}

/// Example of using Shake:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return Shake(child: Text('Bounce'));
///   }
///
/// }
/// ```
class Shake extends AnimatorWidget {
  Shake({
    Key? key,
    required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: ShakeAnimation(preferences: preferences));
}
