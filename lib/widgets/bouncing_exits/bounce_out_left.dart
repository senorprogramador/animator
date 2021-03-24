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

///Used by [BounceOutLeft] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class BounceOutLeftAnimation extends AnimationDefinition {
  BounceOutLeftAnimation({
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
          preferences: preferences,
          needsScreenSize: true,
        );

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return FadeTransition(
      opacity: animator.get("opacity") as Animation<double>,
      child: AnimatedBuilder(
        animation: animator.controller!,
        child: child,
        builder: (BuildContext context, Widget? child) => Transform.translate(
          child: child,
          offset: Offset(animator.get("translateX")!.value, 0.0),
        ),
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size? screenSize, Size? widgetSize}) {
    final curve = Cubic(0.215, 0.61, 0.355, 1);
    return {
      "opacity": TweenList<double>(
        [
          TweenPercentage(percent: 45, value: 1.0, curve: curve),
          TweenPercentage(percent: 100, value: 0.0, curve: curve),
        ],
      ),
      "translateX": TweenList<double>(
        [
          TweenPercentage(percent: 0, value: 0.0, curve: curve),
          TweenPercentage(percent: 20, value: -10.0, curve: curve),
          TweenPercentage(percent: 40, value: 20.0, curve: curve),
          TweenPercentage(percent: 45, value: 20.0, curve: curve),
          TweenPercentage(
              percent: 100, value: -screenSize!.width, curve: curve),
        ],
      ),
    };
  }
}

/// Example of using BounceOutLeft:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return BounceOutLeft(child: Text('Bounce'));
///   }
///
/// }
/// ```
class BounceOutLeft extends AnimatorWidget {
  BounceOutLeft({
    Key? key,
    required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: BounceOutLeftAnimation(preferences: preferences));
}
