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

class ZoomInRight extends AnimatorWidget {
  ZoomInRight({
    Key key,
    @required Widget child,
    AnimatorPreferences prefs = const AnimatorPreferences(),
  }) : super(key: key, child: child, prefs: prefs, needsScreenSize: true);

  @override
  ZoomInRightState createState() => ZoomInRightState();
}

class ZoomInRightState extends AnimatorWidgetState<ZoomInRight> {

  @override
  Widget renderAnimation(BuildContext context) {
    return FadeTransition(
      opacity: animation.get("opacity"),
      child: AnimatedBuilder(
        animation: animation.controller,
        child: widget.child,
        builder: (BuildContext context, Widget child) => Transform(
          child: child,
          transform: Matrix4.translationValues(
                  animation.get("translateX").value, 0.0, 0.0) *
              Matrix4.identity().scaled(animation.get("scale").value),
          alignment: Alignment.centerRight,
        ),
      ),
    );
  }

  @override
  Animator createAnimation(Animator animation) {
    final c0 = Cubic(0.55, 0.55, 0.675, 0.19);
    final c1 = Cubic(0.175, 0.885, 0.32, 1.0);
    return animation
        .at(offset: widget.prefs.offset, duration: widget.prefs.duration)
        .add(
          key: "opacity",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0, curve: c0),
              TweenPercentage(percent: 60, value: 1.0, curve: c1),
            ],
          ),
        )
        .add(
          key: "scale",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.1, curve: c0),
              TweenPercentage(percent: 60, value: 0.475, curve: c1),
              TweenPercentage(percent: 100, value: 1.0, curve: c1),
            ],
          ),
        )
        .add(
          key: "translateX",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: screenSize.width, curve: c0),
              TweenPercentage(percent: 60, value: -60.0, curve: c1),
              TweenPercentage(percent: 100, value: 0.0, curve: c1),
            ],
          ),
        )
        .addStatusListener(widget.prefs.animationStatusListener);
  }
}
