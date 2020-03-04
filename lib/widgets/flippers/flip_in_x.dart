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

enum FlipInXOrigin {
  back,
  front,
}

class FlipInX extends AnimatorWidget {
  final FlipInXOrigin from;
  final Alignment alignment;

  FlipInX({
    Key key,
    @required Widget child,
    AnimatorPreferences prefs = const AnimatorPreferences(),
    this.from = FlipInXOrigin.front,
    this.alignment: Alignment.center,
  }) : super(key: key, child: child, prefs: prefs);

  @override
  FlipInXState createState() => FlipInXState();
}

class FlipInXState extends AnimatorWidgetState<FlipInX> {
  @override
  Widget renderAnimation(BuildContext context) {
    return FadeTransition(
      opacity: animation.get("opacity"),
      child: AnimatedBuilder(
        animation: animation.controller,
        child: widget.child,
        builder: (BuildContext context, Widget child) => Transform(
          transform: Perspective.matrix(4.0) *
              Matrix4.rotationX(-animation.get("rotateX").value),
          child: widget.child,
          alignment: widget.alignment,
        ),
      ),
    );
  }

  @override
  Animator createAnimation(Animator animation) {
    double multiplier = widget.from == FlipInXOrigin.front ? -1.0 : 1.0;
    if (widget.alignment == Alignment.topCenter ||
        widget.alignment == Alignment.topLeft ||
        widget.alignment == Alignment.topRight) {
      multiplier *= -1;
    }

    return animation
        .at(offset: widget.prefs.offset, duration: widget.prefs.duration)
        .add(
          key: "opacity",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0, curve: Curves.easeIn),
              TweenPercentage(percent: 60, value: 1.0),
            ],
          ),
        )
        .add(
          key: "rotateX",
          tweens: TweenList<double>(
            [
              TweenPercentage(
                  percent: 0,
                  value: multiplier * Math.radians(90.0),
                  curve: Curves.easeIn),
              TweenPercentage(
                  percent: 40,
                  value: multiplier * Math.radians(-20.0),
                  curve: Curves.easeIn),
              TweenPercentage(
                  percent: 60, value: multiplier * Math.radians(10.0)),
              TweenPercentage(
                  percent: 80, value: multiplier * Math.radians(-5.0)),
              TweenPercentage(percent: 100, value: 0.0),
            ],
          ),
        )
        .addStatusListener(widget.prefs.animationStatusListener);
  }
}
