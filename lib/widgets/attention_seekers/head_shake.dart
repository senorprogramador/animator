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

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as Math;
import 'package:flutter/widgets.dart';
import '../../utils/animator.dart';

class HeadShake extends StatefulWidget {
  final Widget child;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  HeadShake({
    @required this.child,
    this.offset = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
    this.animationStatusListener,
  }) {
    assert(child != null, 'Error: child in $this cannot be null');
    assert(offset != null, 'Error: offset in $this cannot be null');
    assert(duration != null, 'Error: duration in $this cannot be null');
  }

  @override
  _HeadShakeState createState() => _HeadShakeState();
}

class _HeadShakeState extends State<HeadShake> with SingleAnimatorStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation.controller,
      child: widget.child,
      builder: (BuildContext context, Widget child) => Transform(
        child: child,
        transform: Matrix4.translationValues(
                animation.get("translateX").value, 0.0, 0.0) *
            Matrix4.rotationY(animation.get("rotateY").value),
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  @override
  Animator createAnimation() {
    final curve = Curves.easeInOut;
    return Animator.sync(this)
        .at(offset: widget.offset, duration: widget.duration)
        .add(
          key: "translateX",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0, curve: curve),
              TweenPercentage(percent: 13, value: -6.0, curve: curve),
              TweenPercentage(percent: 37, value: 5.0, curve: curve),
              TweenPercentage(percent: 63, value: -3.0, curve: curve),
              TweenPercentage(percent: 87, value: 2.0, curve: curve),
              TweenPercentage(percent: 100, value: 0.0, curve: curve),
            ],
          ),
        )
        .add(
          key: "rotateY",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0, curve: curve),
              TweenPercentage(
                  percent: 13, value: Math.radians(-9.0), curve: curve),
              TweenPercentage(
                  percent: 37, value: Math.radians(7.0), curve: curve),
              TweenPercentage(
                  percent: 63, value: Math.radians(-5.0), curve: curve),
              TweenPercentage(
                  percent: 87, value: Math.radians(3.0), curve: curve),
              TweenPercentage(percent: 100, value: 0.0, curve: curve),
            ],
          ),
        )
        .addStatusListener(widget.animationStatusListener)
        .generate();
  }
}
