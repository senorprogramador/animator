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

///Used by [BounceIn] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class BounceInAnimation extends AnimationDefinition {
  BounceInAnimation({
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(preferences: preferences);

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return FadeTransition(
      opacity: animator.get("opacity") as Animation<double>,
      child: AnimatedBuilder(
        animation: animator.controller!,
        child: child,
        builder: (BuildContext context, Widget? child) => Transform.scale(
          child: child,
          scale: animator.get("scale")!.value,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size? screenSize, Size? widgetSize}) {
    final curve = Cubic(0.215, 0.61, 0.355, 1);
    return {
      "opacity": TweenList<double?>(
        [
          TweenPercentage(percent: 0, value: 0.0, curve: curve),
          TweenPercentage(percent: 60, value: 1.0, curve: curve),
        ],
      ),
      "scale": TweenList<double?>(
        [
          TweenPercentage(percent: 0, value: 0.3, curve: curve),
          TweenPercentage(percent: 20, value: 1.1, curve: curve),
          TweenPercentage(percent: 40, value: 0.9, curve: curve),
          TweenPercentage(percent: 60, value: 1.03, curve: curve),
          TweenPercentage(percent: 80, value: 0.97, curve: curve),
          TweenPercentage(percent: 100, value: 1.0),
        ],
      ),
    };
  }
}

/// Example of using BounceIn:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return BounceIn(child: Text('Bounce'));
///   }
///
/// }
/// ```
class BounceIn extends AnimatorWidget {
  BounceIn({
    Key? key,
    required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: BounceInAnimation(preferences: preferences));
}
