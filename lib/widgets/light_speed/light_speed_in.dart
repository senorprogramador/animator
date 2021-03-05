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

///Used by [LightSpeedIn] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class LightSpeedInAnimation extends AnimationDefinition {
  LightSpeedInAnimation({
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
          preferences: preferences,
          needsScreenSize: true,
          preRenderOpacity: 0.0,
        );

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return FadeTransition(
      opacity: animator.get("opacity") as Animation<double>,
      child: AnimatedBuilder(
        animation: animator.controller!,
        child: child,
        builder: (BuildContext context, Widget? child) => Transform(
          child: child,
          transform: Matrix4.translationValues(
                  animator.get("translateX")!.value, 0.0, 0.0) *
              Matrix4.skewX(animator.get("skewX")!.value),
          alignment: Alignment.center,
        ),
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size? screenSize, Size? widgetSize}) {
    return {
      "opacity": TweenList<double?>(
        [
          TweenPercentage(percent: 0, value: 0.0),
          TweenPercentage(percent: 60, value: 1.0),
        ],
      ),
      "translateX": TweenList<double?>(
        [
          TweenPercentage(percent: 0, value: screenSize!.width),
          TweenPercentage(percent: 100, value: 0.0),
        ],
      ),
      "skewX": TweenList<double?>(
        [
          TweenPercentage(percent: 0, value: -30.0 * toRad),
          TweenPercentage(percent: 60, value: 20.0 * toRad),
          TweenPercentage(percent: 80, value: -5.0 * toRad),
          TweenPercentage(percent: 100, value: 0.0),
        ],
      ),
    };
  }
}

/// Example of using LightSpeedIn:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return LightSpeedIn(child: Text('Bounce'));
///   }
///
/// }
/// ```
class LightSpeedIn extends AnimatorWidget {
  LightSpeedIn({
    Key? key,
    required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: LightSpeedInAnimation(preferences: preferences));
}
