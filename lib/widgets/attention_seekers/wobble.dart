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

class Wobble extends AnimatorWidget {

  Wobble({
    Key key,
    @required Widget child,
    AnimatorPreferences prefs = const AnimatorPreferences(),
  }) : super(key: key, child: child, prefs: prefs, needsScreenSize: true);

  @override
  WobbleState createState() => WobbleState();
}

class WobbleState extends AnimatorWidgetState<Wobble> {

  @override
  Widget renderAnimation(BuildContext context) {
    return AnimatedBuilder(
      animation: animation.controller,
      child: widget.child,
      builder: (BuildContext context, Widget child) => Transform(
        child: child,
        transform: animation.get("transform").value,
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Animator createAnimation(Animator animation) {
    final width = screenSize.width;
    final axis = Math.Vector3(0.0, 0.0, 1.0);
    final m = Matrix4.identity();
    final m15 = Matrix4.translationValues(-0.25 * width, 0.0, 0.0);
    m15.rotate(axis, Math.radians(-5.0));

    final m30 = Matrix4.translationValues(0.2 * width, 0.0, 0.0);
    m30.rotate(axis, Math.radians(3.0));

    final m45 = Matrix4.translationValues(-0.15 * width, 0.0, 0.0);
    m45.rotate(axis, Math.radians(-3.0));

    final m60 = Matrix4.translationValues(0.1 * width, 0.0, 0.0);
    m60.rotate(axis, Math.radians(2.0));

    final m75 = Matrix4.translationValues(-0.05 * width, 0.0, 0.0);
    m75.rotate(axis, Math.radians(-1.0));

    return animation
        .at(offset: widget.prefs.offset, duration: widget.prefs.duration)
        .add(
          key: "transform",
          tweens: TweenList<Matrix4>(
            [
              TweenPercentage(percent: 0, value: m),
              TweenPercentage(percent: 15, value: m15),
              TweenPercentage(percent: 30, value: m30),
              TweenPercentage(percent: 45, value: m45),
              TweenPercentage(percent: 60, value: m60),
              TweenPercentage(percent: 75, value: m75),
              TweenPercentage(percent: 100, value: m),
            ],
          ),
        )
        .addStatusListener(widget.prefs.animationStatusListener);
  }
}
