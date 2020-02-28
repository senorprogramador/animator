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

import 'package:vector_math/vector_math_64.dart' as Math;
import 'package:flutter/widgets.dart';
import '../../utils/animator.dart';

class RollOut extends StatefulWidget {
  final Widget child;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  RollOut({
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
  _RollOutState createState() => _RollOutState();
}

class _RollOutState extends State<RollOut> {
  Size size;
  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _key.currentContext.findRenderObject();
      setState(() {
        size = renderBox.size;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (size == null) {
      return Container(key: _key, child: widget.child);
    }
    return _RollOutAnimation(
      child: widget.child,
      size: size,
      offset: widget.offset,
      duration: widget.duration,
      animationStatusListener: widget.animationStatusListener,
    );
  }
}

class _RollOutAnimation extends StatefulWidget {
  final Widget child;
  final Size size;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  _RollOutAnimation({
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
  __RollOutAnimationState createState() => __RollOutAnimationState();
}

class __RollOutAnimationState extends State<_RollOutAnimation>
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
                  animation.get("translateX").value, 0.0, 0.0) *
              Matrix4.rotationZ(animation.get("rotateZ").value),
          alignment: Alignment.center,
        ),
      ),
    );
  }

  @override
  Animator createAnimation() {
    return Animator.sync(this)
        .at(offset: widget.offset, duration: widget.duration)
        .add(
          key: "opacity",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 1.0),
              TweenPercentage(percent: 100, value: 0.0),
            ],
          ),
        )
        .add(
          key: "translateX",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0),
              TweenPercentage(percent: 100, value: widget.size.width),
            ],
          ),
        )
        .add(
          key: "rotateZ",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0),
              TweenPercentage(percent: 100, value: Math.radians(120.0)),
            ],
          ),
        )
        .addStatusListener(widget.animationStatusListener)
        .generate();
  }
}
