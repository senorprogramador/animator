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

class BounceInDown extends StatefulWidget {
  final Widget child;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  BounceInDown({
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
  _BounceInDownState createState() => _BounceInDownState();
}

class _BounceInDownState extends State<BounceInDown> {
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
    return _BounceInDownAnimation(
      child: widget.child,
      size: size,
      offset: widget.offset,
      duration: widget.duration,
      animationStatusListener: widget.animationStatusListener,
    );
  }
}

class _BounceInDownAnimation extends StatefulWidget {
  final Widget child;
  final Size size;
  final Duration offset;
  final Duration duration;
  final AnimationStatusListener animationStatusListener;

  _BounceInDownAnimation({
    @required this.child,
    @required this.size,
    this.animationStatusListener,
    this.offset = Duration.zero,
    this.duration = const Duration(seconds: 1),
  });

  @override
  __BounceInDownAnimationState createState() => __BounceInDownAnimationState();
}

class __BounceInDownAnimationState extends State<_BounceInDownAnimation>
    with SingleAnimatorStateMixin {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation.get("opacity"),
      child: AnimatedBuilder(
        animation: animation.controller,
        child: widget.child,
        builder: (BuildContext context, Widget child) => Transform.translate(
          child: child,
          offset: Offset(0.0, animation.get("translateY").value),
        ),
      ),
    );
  }

  @override
  Animator createAnimation() {
    final curve = Cubic(0.215, 0.61, 0.355, 1);
    return Animator.sync(this)
        .at(offset: widget.offset, duration: widget.duration)
        .add(
          key: "opacity",
          tweens: TweenList<double>(
            [
              TweenPercentage(percent: 0, value: 0.0, curve: curve),
              TweenPercentage(percent: 60, value: 1.0, curve: curve),
            ],
          ),
        )
        .add(
          key: "translateY",
          tweens: TweenList<double>(
            [
              TweenPercentage(
                  percent: 0, value: -widget.size.height, curve: curve),
              TweenPercentage(percent: 60, value: 25.0, curve: curve),
              TweenPercentage(percent: 75, value: -10.0, curve: curve),
              TweenPercentage(percent: 90, value: 5.0, curve: curve),
              TweenPercentage(percent: 100, value: 0.0, curve: curve),
            ],
          ),
        )
        .addStatusListener(widget.animationStatusListener)
        .generate();
  }
}
