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
import 'package:vector_math/vector_math_64.dart' as Math;

import '../../flutter_animator.dart';

///Used by [Tada] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class TadaAnimation extends AnimationDefinition {
  TadaAnimation({
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(preferences: preferences);

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return AnimatedBuilder(
      animation: animator.controller!,
      child: child,
      builder: (BuildContext context, Widget? child) => Transform(
        child: child,
        transform: animator.get("transform")!.value,
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size? screenSize, Size? widgetSize}) {
    final axis = Math.Vector3(0.0, 0.0, 1.0);
    final m = Matrix4.identity();

    final m10 = m.scaled(1.0 - 0.1 * preferences.magnitude);
    m10.rotate(axis, -3.0 * toRad * preferences.magnitude);

    final m30 = m.scaled(1.0 + 0.1 * preferences.magnitude);
    m30.rotate(axis, 3.0 * toRad * preferences.magnitude);

    final m40 = m.scaled(1.0 + 0.1 * preferences.magnitude);
    m40.rotate(axis, -3.0 * toRad * preferences.magnitude);

    return {
      "transform": TweenList<Matrix4>(
        [
          TweenPercentage(percent: 0, value: m),
          TweenPercentage(percent: 10, value: m10),
          TweenPercentage(percent: 20, value: m10),
          TweenPercentage(percent: 30, value: m30),
          TweenPercentage(percent: 40, value: m40),
          TweenPercentage(percent: 50, value: m30),
          TweenPercentage(percent: 60, value: m40),
          TweenPercentage(percent: 70, value: m30),
          TweenPercentage(percent: 80, value: m40),
          TweenPercentage(percent: 90, value: m30),
          TweenPercentage(percent: 100, value: m),
        ],
      ),
    };
  }
}

/// Example of using Tada:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return Tada(child: Text('Bounce'));
///   }
///
/// }
/// ```
class Tada extends AnimatorWidget {
  Tada({
    Key? key,
    required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            key: key,
            child: child,
            definition: TadaAnimation(preferences: preferences));
}
