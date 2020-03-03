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

import 'dart:math';

import 'package:vector_math/vector_math_64.dart' as Math;
import 'package:flutter/widgets.dart';
import '../../utils/animator.dart';

class Wobble extends StatefulWidget {
  final Widget child;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  Wobble({
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
  _WobbleState createState() => _WobbleState();
}

class _WobbleState extends State<Wobble> {
  Size size;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox = context.findRenderObject();
      final screenSize = MediaQuery.of(context).size;
      setState(() {
        size = Size(min(renderBox.size.width, 0.5 * screenSize.width - 10.0),
            min(renderBox.size.height, 0.5 * screenSize.height - 10.0));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (size == null) {
      return Opacity(
        opacity: 1.0,
        child: widget.child,
      );
    }
    return _WobbleAnimation(
      child: widget.child,
      size: size,
      offset: widget.offset,
      duration: widget.duration,
      animationStatusListener: widget.animationStatusListener,
    );
  }
}

class _WobbleAnimation extends StatefulWidget {
  final Widget child;
  final Duration offset;
  final Duration duration;
  final Size size;
  final AnimationStatusListener animationStatusListener;

  _WobbleAnimation({
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
  __WobbleAnimationState createState() => __WobbleAnimationState();
}

class __WobbleAnimationState extends State<_WobbleAnimation>
    with SingleAnimatorStateMixin {
  @override
  Widget build(BuildContext context) {
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
  Animator createAnimation() {
    final width = widget.size.width;
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

    return Animator.sync(this)
        .at(offset: widget.offset, duration: widget.duration)
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
        .addStatusListener(widget.animationStatusListener)
        .generate();
  }
}
