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

import 'package:vector_math/vector_math.dart' as Math;
import 'package:flutter/widgets.dart';
import '../../utils/animator.dart';

class Jello extends StatefulWidget {
  final Widget child;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  Jello({
    @required this.child,
    this.offset = Duration.zero,
    this.duration = const Duration(seconds: 1),
    this.animationStatusListener,
  }) {
    assert(child != null, 'Error: child in $this cannot be null');
    assert(offset != null, 'Error: offset in $this cannot be null');
    assert(duration != null, 'Error: duration in $this cannot be null');
  }

  @override
  _JelloState createState() => _JelloState();
}

class _JelloState extends State<Jello> with SingleAnimatorStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation.controller,
      child: widget.child,
      builder: (BuildContext context, Widget child) => Transform(
        child: child,
        transform: Matrix4.skew(
            animation.get("transform").value, animation.get("transform").value),
        alignment: new FractionalOffset(0.5, 0.5),
      ),
    );
  }

  @override
  Animator createAnimation() {
    return Animator.sync(this)
        .at(offset: widget.offset, duration: widget.duration)
        .add(
          key: "transform",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 11, value: 0.0),
              TweenPercentage(
                percent: 22,
                value: Math.radians(-12.5),
              ),
              TweenPercentage(
                percent: 33,
                value: Math.radians(6.25),
              ),
              TweenPercentage(
                percent: 44,
                value: Math.radians(-3.125),
              ),
              TweenPercentage(
                percent: 55,
                value: Math.radians(-1.5625),
              ),
              TweenPercentage(
                percent: 66,
                value: Math.radians(-0.78125),
              ),
              TweenPercentage(
                percent: 77,
                value: Math.radians(0.390625),
              ),
              TweenPercentage(
                percent: 88,
                value: Math.radians(-0.1953125),
              ),
              TweenPercentage(percent: 100, value: 0.0),
            ],
          ),
        )
        .addStatusListener(widget.animationStatusListener)
        .generate();
  }
}
