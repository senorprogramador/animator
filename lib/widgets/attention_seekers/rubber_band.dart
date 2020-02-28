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
import '../../utils/animator.dart';

class RubberBand extends StatefulWidget {
  final Widget child;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  RubberBand({
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
  _RubberBandState createState() => _RubberBandState();
}

class _RubberBandState extends State<RubberBand> with SingleAnimatorStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => animation.controller.forward(from: 0.0), child: AnimatedBuilder(
      animation: animation.controller,
      child: widget.child,
      builder: (BuildContext context, Widget child) => Transform(
        child: child,
        transform: animation.get("transform").value,
        alignment: new FractionalOffset(0.5, 0.5),
      ),
    ),);
  }

  @override
  Animator createAnimation() {
    final m = Matrix4.identity();
    return Animator.sync(this)
        .at(offset: widget.offset, duration: widget.duration)
        .add(
          key: "transform",
          tweens: TweenList<Matrix4>(
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
        )
        .addStatusListener(widget.animationStatusListener)
        .generate();
  }
}
