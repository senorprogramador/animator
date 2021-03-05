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

///Used by [Hinge] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class HingeAnimation extends AnimationDefinition {
  HingeAnimation({
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
              Matrix4.translationValues(
                  0.0, animator.get("translateY")!.value, 0.0) *
              Matrix4.rotationZ(animator.get("rotateZ")!.value),
          child: child,
          alignment: Alignment.topLeft,
        ),
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size? screenSize, Size? widgetSize}) {
    const curve = Curves.easeInOut;
    return {
      "opacity": TweenList<double?>(
        [
          TweenPercentage(percent: 80, value: 1.0, curve: curve),
          TweenPercentage(percent: 100, value: 0.0, curve: curve),
        ],
      ),
      "translateY": TweenList<double?>(
        [
          TweenPercentage(percent: 80, value: 0.0, curve: curve),
          TweenPercentage(percent: 100, value: 700.0, curve: curve),
        ],
      ),
      "rotateZ": TweenList<double?>(
        [
          TweenPercentage(percent: 0, value: 0.0, curve: curve),
          TweenPercentage(percent: 20, value: 80.0 * toRad, curve: curve),
          TweenPercentage(percent: 40, value: 60.0 * toRad, curve: curve),
          TweenPercentage(percent: 60, value: 80.0 * toRad, curve: curve),
          TweenPercentage(percent: 80, value: 60.0 * toRad, curve: curve),
          TweenPercentage(percent: 100, value: 0.0, curve: curve),
        ],
      ),
    };
  }
}

/// Example of using Hinge:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return Hinge(child: Text('Bounce'));
///   }
///
/// }
/// ```
class Hinge extends AnimatorWidget {
  Hinge({
    Key? key,
    required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: HingeAnimation(preferences: preferences));
}
