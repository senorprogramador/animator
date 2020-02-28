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

class ZoomOutUp extends StatefulWidget {
  final Widget child;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  ZoomOutUp({
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
  _ZoomOutUpState createState() => _ZoomOutUpState();
}

class _ZoomOutUpState extends State<ZoomOutUp> {
  Size size;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        size = MediaQuery.of(context).size;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (size == null) {
      return widget.child;
    }
    return _ZoomOutUpAnimation(
      child: widget.child,
      size: size,
      offset: widget.offset,
      duration: widget.duration,
      animationStatusListener: widget.animationStatusListener,
    );
  }
}

class _ZoomOutUpAnimation extends StatefulWidget {
  final Widget child;
  final Size size;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  _ZoomOutUpAnimation({
    @required this.child,
    @required this.size,
    this.offset = Duration.zero,
    this.duration = const Duration(seconds: 1),
    this.animationStatusListener,
  }) {
    assert(child != null, 'Error: child in $this cannot be null');
    assert(offset != null, 'Error: offset in $this cannot be null');
    assert(duration != null, 'Error: duration in $this cannot be null');
  }

  @override
  __ZoomOutUpAnimationState createState() => __ZoomOutUpAnimationState();
}

class __ZoomOutUpAnimationState extends State<_ZoomOutUpAnimation>
    with SingleAnimatorStateMixin {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation.get("opacity"),
      child: AnimatedBuilder(
        animation: animation.controller,
        child: widget.child,
        builder: (BuildContext context, Widget child) => Transform(
          child: child,
          transform: Matrix4.translationValues(
                  0.0, animation.get("translateY").value, 0.0) *
              Matrix4.identity().scaled(animation.get("scale").value),
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }

  @override
  Animator createAnimation() {
    final c0 = Cubic(0.55, 0.55, 0.675, 0.19);
    final c1 = Cubic(0.175, 0.885, 0.32, 1.0);
    return Animator.sync(this)
        .at(offset: widget.offset, duration: widget.duration)
        .add(
          key: "opacity",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 40, value: 1.0, curve: c0),
              TweenPercentage(percent: 100, value: 0.0, curve: c1),
            ],
          ),
        )
        .add(
          key: "scale",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 1.0, curve: c0),
              TweenPercentage(percent: 40, value: 0.475, curve: c0),
              TweenPercentage(percent: 100, value: 0.1, curve: c1),
            ],
          ),
        )
        .add(
          key: "translateY",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0, curve: c0),
              TweenPercentage(percent: 40, value: 60.0, curve: c0),
              TweenPercentage(
                  percent: 100, value: -widget.size.height, curve: c1),
            ],
          ),
        )
        .addStatusListener(widget.animationStatusListener)
        .generate();
  }
}
