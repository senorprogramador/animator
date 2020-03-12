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

///Used by [BounceInDown] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class BounceInDownAnimation extends AnimationDefinition {
  BounceInDownAnimation({
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
          preferences: preferences,
          needsScreenSize: true,
          preRenderOpacity: 0.0,
        );

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return FadeTransition(
      opacity: animator.get("opacity"),
      child: AnimatedBuilder(
        animation: animator.controller,
        child: child,
        builder: (BuildContext context, Widget child) => Transform.translate(
          child: child,
          offset: Offset(0.0, animator.get("translateY").value),
        ),
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size screenSize, Size widgetSize}) {
    final curve = Cubic(0.215, 0.61, 0.355, 1);
    return {
      "opacity": TweenList<double>(
        [
          TweenPercentage(percent: 0, value: 0.0, curve: curve),
          TweenPercentage(percent: 60, value: 1.0, curve: curve),
        ],
      ),
      "translateY": TweenList<double>(
        [
          TweenPercentage(percent: 0, value: -screenSize.height, curve: curve),
          TweenPercentage(percent: 60, value: 25.0, curve: curve),
          TweenPercentage(percent: 75, value: -10.0, curve: curve),
          TweenPercentage(percent: 90, value: 5.0, curve: curve),
          TweenPercentage(percent: 100, value: 0.0, curve: curve),
        ],
      ),
    };
  }
}

/// Example of using BounceInDown:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return BounceInDown(child: Text('Bounce'));
///   }
///
/// }
/// ```
class BounceInDown extends AnimatorWidget {
  BounceInDown({
    Key key,
    @required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: BounceInDownAnimation(preferences: preferences));
}
