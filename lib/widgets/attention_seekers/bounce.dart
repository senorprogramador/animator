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


class Bounce extends AnimatorWidget {
  Bounce({
    Key key,
    @required Widget child,
    AnimatorPreferences prefs = const AnimatorPreferences(),
  }) : super(key: key, child: child, prefs: prefs);

  @override
  BounceState createState() => BounceState();
}

class BounceState extends AnimatorWidgetState<Bounce> {
  @override
  Widget renderAnimation(BuildContext context) {
    return AnimatedBuilder(
      animation: animation.controller,
      child: widget.child,
      builder: (BuildContext context, Widget child) => Transform(
        child: child,
        transform: Matrix4.translationValues(
            0.0, animation.get("translateY").value, 0.0),
        alignment: new FractionalOffset(0.5, 1.0),
      ),
    );
  }

  @override
  Animator createAnimation(Animator animation) {
    final floorCurve = Cubic(0.215, 0.61, 0.355, 1);
    final ceilCurve = Cubic(0.755, 0.05, 0.855, 0.06);
    return animation
        .at(offset: widget.prefs.offset, duration: widget.prefs.duration)
        .add(
          key: "translateY",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0, curve: floorCurve),
              TweenPercentage(percent: 20, value: 0.0, curve: floorCurve),
              TweenPercentage(percent: 40, value: -30.0, curve: ceilCurve),
              TweenPercentage(percent: 43, value: -30.0, curve: ceilCurve),
              TweenPercentage(percent: 53, value: 0.0, curve: floorCurve),
              TweenPercentage(percent: 70, value: -15.0, curve: ceilCurve),
              TweenPercentage(percent: 80, value: 0.0, curve: floorCurve),
              TweenPercentage(percent: 90, value: -4.0),
              TweenPercentage(percent: 100, value: 0.0, curve: floorCurve),
            ],
          ),
        )
        .addStatusListener(widget.prefs.animationStatusListener);
  }
}
