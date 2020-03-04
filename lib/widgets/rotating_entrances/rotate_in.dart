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



class RotateIn extends AnimatorWidget {
  RotateIn({
    Key key,
    @required Widget child,
    AnimatorPreferences prefs = const AnimatorPreferences(),
  }) : super(key: key, child: child, prefs: prefs);

  @override
  RotateInState createState() => RotateInState();
}

class RotateInState extends AnimatorWidgetState<RotateIn> {
  @override
  Widget renderAnimation(BuildContext context) {
    return FadeTransition(
      opacity: animation.get("opacity"),
      child: AnimatedBuilder(
        animation: animation.controller,
        child: widget.child,
        builder: (BuildContext context, Widget child) => Transform.rotate(
          angle: -animation.get("rotateZ").value,
          child: widget.child,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  @override
  Animator createAnimation(Animator animation) {
    return animation
        .at(offset: widget.prefs.offset, duration: widget.prefs.duration)
        .add(
          key: "opacity",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0),
              TweenPercentage(percent: 100, value: 1.0),
            ],
          ),
        )
        .add(
          key: "rotateZ",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: Math.radians(-200.0)),
              TweenPercentage(percent: 100, value: 0.0),
            ],
          ),
        )
        .addStatusListener(widget.prefs.animationStatusListener);
  }
}
