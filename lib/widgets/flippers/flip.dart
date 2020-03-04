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

import '../../flutter_animator.dart';
import 'package:vector_math/vector_math_64.dart' as Math;
import 'package:flutter/widgets.dart';

import '../../utils/perspective.dart';

class Flip extends AnimatorWidget {
  Flip({
    Key key,
    @required Widget child,
    AnimatorPreferences prefs = const AnimatorPreferences(),
  }) : super(key: key, child: child, prefs: prefs);

  @override
  FlipState createState() => FlipState();
}

class FlipState extends AnimatorWidgetState<Flip> {
  @override
  Widget renderAnimation(BuildContext context) {
    return AnimatedBuilder(
      animation: animation.controller,
      child: widget.child,
      builder: (BuildContext context, Widget child) => Transform(
        transform: Perspective.matrix(4.0) *
            Matrix4.translationValues(
                0.0, 0.0, animation.get("translateZ").value) *
            Matrix4.rotationY(-animation.get("rotateY").value) *
            Matrix4.identity().scaled(animation.get("scale").value),
        child: widget.child,
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Animator createAnimation(Animator animation) {
    final cIn = Curves.easeIn;
    final cOut = Curves.easeOut;

    return animation
        .at(offset: widget.prefs.offset, duration: widget.prefs.duration)
        .add(
          key: "scale",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 1.0, curve: cOut),
              TweenPercentage(percent: 40, value: 1.0, curve: cOut),
              TweenPercentage(percent: 50, value: 1.0, curve: cIn),
              TweenPercentage(percent: 80, value: 0.95, curve: cIn),
              TweenPercentage(percent: 100, value: 1.0, curve: cIn),
            ],
          ),
        )
        .add(
          key: "translateZ",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0, curve: cOut),
              TweenPercentage(percent: 40, value: -150.0, curve: cOut),
              TweenPercentage(percent: 50, value: -150.0, curve: cIn),
              TweenPercentage(percent: 80, value: 0.0, curve: cIn),
            ],
          ),
        )
        .add(
          key: "rotateY",
          tweens: TweenList<double>(
            [
              TweenPercentage(
                  percent: 0, value: Math.radians(-360.0), curve: cOut),
              TweenPercentage(
                  percent: 40, value: Math.radians(-190.0), curve: cOut),
              TweenPercentage(
                  percent: 50, value: Math.radians(-170.0), curve: cIn),
              TweenPercentage(percent: 80, value: 0.0, curve: cIn),
            ],
          ),
        )
        .addStatusListener(widget.prefs.animationStatusListener);
  }
}
