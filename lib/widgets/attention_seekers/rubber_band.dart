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

class RubberBandAnimation extends AnimationDefinition {
  RubberBandAnimation({
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(preferences: preferences);

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return AnimatedBuilder(
      animation: animator.controller,
      child: child,
      builder: (BuildContext context, Widget child) => Transform(
        child: child,
        transform: animator.get("transform").value,
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size screenSize, Size widgetSize}) {
    final m = Matrix4.identity();
    return {
      "transform": TweenList<Matrix4>(
        [
          TweenPercentage(percent: 0, value: m),
          TweenPercentage(percent: 30, value: m.scaled(1.25, 0.75, 1.0)),
          TweenPercentage(percent: 40, value: m.scaled(0.75, 1.25, 1.0)),
          TweenPercentage(percent: 50, value: m.scaled(1.15, 0.85, 1.0)),
          TweenPercentage(percent: 65, value: m.scaled(0.95, 1.05, 1.0)),
          TweenPercentage(percent: 75, value: m.scaled(1.05, 0.95, 1.0)),
          TweenPercentage(percent: 100, value: m),
        ],
      ),
    };
  }
}

class RubberBand extends AnimatorWidget {
  RubberBand({
    Key key,
    @required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: RubberBandAnimation(preferences: preferences));
}
